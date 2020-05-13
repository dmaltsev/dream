//
//  MediaBrandAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class MediaBrandModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> MediaBrandViewController {
        return unwrap(container.resolve(MediaBrandViewController.self))
    }
    
    func configureModuleForViewInput(viewInput: MediaBrandViewController) {
        viewInput.output = container.resolve(MediaBrandViewOutput.self, argument: viewInput as MediaBrandViewInput)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(MediaBrandViewController.self) { resolver in
            let controller = MediaBrandViewController()
            controller.output = resolver.resolve(MediaBrandViewOutput.self, argument: controller as MediaBrandViewInput)
            return controller
        }
        
        container.register(MediaBrandRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = MediaBrandRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(MediaBrandViewOutput.self) { (resolver, view: MediaBrandViewInput) in
            let presenter = MediaBrandPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? MediaBrandPresenter {
                presenter.interactor = resolver.resolve(MediaBrandInteractorInput.self, argument: presenter as MediaBrandInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(MediaBrandRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(MediaBrandInteractorInput.self) { (resolver, interactorOutput: MediaBrandInteractorOutput) in
            let interactor = MediaBrandInteractor()
            interactor.output = interactorOutput
            return interactor
        }
    }
}