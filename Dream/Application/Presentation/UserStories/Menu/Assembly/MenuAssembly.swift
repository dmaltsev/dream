//
//  MenuAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class MenuModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> MenuViewController {
        return unwrap(container.resolve(MenuViewController.self))
    }

    func configureModuleForViewInput(viewInput: MenuViewController) {
        viewInput.output = container.resolve(MenuViewOutput.self, argument: viewInput as MenuViewInput)
        viewInput.contentManager = container.resolve(MenuContentManager.self)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(MenuViewController.self) { resolver in
            let controller = MenuViewController()
            controller.output = resolver.resolve(MenuViewOutput.self, argument: controller as MenuViewInput)
            controller.contentManager = resolver.resolve(MenuContentManager.self)
            return controller
        }
        
        container.register(MenuRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = MenuRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(MenuViewOutput.self) { (resolver, view: MenuViewInput) in
            let menuCellViewModelDesigner = resolver.resolve(MenuCellViewModelDesigner.self).unwrap()
            let presenter = MenuPresenter(menuCellViewModelDesigner: menuCellViewModelDesigner)
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? MenuPresenter {
                presenter.interactor = resolver.resolve(MenuInteractorInput.self, argument: presenter as MenuInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(MenuRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(MenuInteractorInput.self) { (resolver, interactorOutput: MenuInteractorOutput) in
            let interactor = MenuInteractor()
            interactor.output = interactorOutput
            return interactor
        }
        
        container.register(MenuCellControllerFactory.self) { resolver in
            return MenuCellControllerFactoryImplementation()
        }
        
        container.register(MenuCellViewModelDesigner.self) { resolver in
            return MenuCellViewModelDesignerImplementation()
        }
            
        container.register(MenuContentManager.self) { resolver in
            let controllersFactory = resolver.resolve(MenuCellControllerFactory.self).unwrap()
            let contentManager = MenuContentManagerImplementation(controllersFactory: controllersFactory)
            return contentManager
        }
    }
}
