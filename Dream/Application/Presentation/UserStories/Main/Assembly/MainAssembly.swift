//
//  MainAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class MainModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> MainViewController {
        return unwrap(container.resolve(MainViewController.self))
    }

    func configureModuleForViewInput(viewInput: MainViewController) {
        viewInput.output = container.resolve(MainViewOutput.self, argument: viewInput as MainViewInput)
        viewInput.contentManager = container.resolve(MainContentManager.self, argument: viewInput as MainContentManagerImplementationDelegate)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(MainViewController.self) { resolver in
            let controller = MainViewController()
            controller.output = resolver.resolve(MainViewOutput.self, argument: controller as MainViewInput)
            controller.contentManager = resolver.resolve(MainContentManager.self, argument: controller as MainContentManagerImplementationDelegate)
            return controller
        }
        
        container.register(MainRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = MainRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(MainViewOutput.self) { (resolver, view: MainViewInput) in
            let cardCellViewModelDesigner = resolver.resolve(CardCellViewModelDesigner.self).unwrap()
            let presenter = MainPresenter(cardCellViewModelDesigner: cardCellViewModelDesigner)
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? MainPresenter {
                presenter.interactor = resolver.resolve(MainInteractorInput.self, argument: presenter as MainInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(MainRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(MainInteractorInput.self) { (resolver, interactorOutput: MainInteractorOutput) in
            let feedService = resolver.resolve(FeedService.self).unwrap()
            let interactor = MainInteractor(feedService: feedService)
            interactor.output = interactorOutput
            return interactor
        }
        
        container.register(CardCellControllerFactory.self) { resolver in
            let container = resolver.resolve(Container.self).unwrap()
            return CardCellControllerFactoryImplementation(container: container)
        }
        
        container.register(CardCellViewModelDesigner.self) { resolver in
            return CardCellViewModelDesignerImplementation()
        }
            
        container.register(MainContentManager.self) { (resolver, delegate: MainContentManagerImplementationDelegate) in
            let controllersFactory = resolver.resolve(CardCellControllerFactory.self).unwrap()
            let contentManager = MainContentManagerImplementation(controllersFactory: controllersFactory)
            contentManager.delegate = delegate
            return contentManager
        }
    }
}
