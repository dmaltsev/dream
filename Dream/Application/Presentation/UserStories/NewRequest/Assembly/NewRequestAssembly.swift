//
//  NewRequestAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class NewRequestModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> NewRequestViewController {
        return unwrap(container.resolve(NewRequestViewController.self))
    }
    
    func configureModuleForViewInput(viewInput: NewRequestViewController) {
        viewInput.output = container.resolve(NewRequestViewOutput.self, argument: viewInput as NewRequestViewInput)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(NewRequestViewController.self) { resolver in
            let controller = NewRequestViewController()
            controller.output = resolver.resolve(NewRequestViewOutput.self, argument: controller as NewRequestViewInput)
            return controller
        }
        
        container.register(NewRequestRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = NewRequestRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(NewRequestViewOutput.self) { (resolver, view: NewRequestViewInput) in
            let presenter = NewRequestPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? NewRequestPresenter {
                presenter.interactor = resolver.resolve(NewRequestInteractorInput.self, argument: presenter as NewRequestInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(NewRequestRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(NewRequestInteractorInput.self) { (resolver, interactorOutput: NewRequestInteractorOutput) in
            let userService = resolver.resolve(UserService.self).unwrap()
            let mediaService = resolver.resolve(MediaService.self).unwrap()
            let postService = resolver.resolve(PostService.self).unwrap()
            
            let interactor = NewRequestInteractor(userService: userService, mediaService: mediaService, postService: postService)
            interactor.output = interactorOutput
            return interactor
        }
    }
}
