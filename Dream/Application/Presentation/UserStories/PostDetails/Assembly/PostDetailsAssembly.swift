//
//  PostDetailsAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class PostDetailsModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> PostDetailsViewController {
        return unwrap(container.resolve(PostDetailsViewController.self))
    }
    
    func configureModuleForViewInput(viewInput: PostDetailsViewController) {
        viewInput.output = container.resolve(PostDetailsViewOutput.self, argument: viewInput as PostDetailsViewInput)
        viewInput.contentManager = container.resolve(CommentsContentManager.self)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(PostDetailsViewController.self) { resolver in
            let controller = PostDetailsViewController()
            controller.output = resolver.resolve(PostDetailsViewOutput.self, argument: controller as PostDetailsViewInput)
            controller.contentManager = resolver.resolve(CommentsContentManager.self)
            return controller
        }
        
        container.register(PostDetailsRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = PostDetailsRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(PostDetailsViewOutput.self) { (resolver, view: PostDetailsViewInput) in
            let presenter = PostDetailsPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? PostDetailsPresenter {
                presenter.interactor = resolver.resolve(PostDetailsInteractorInput.self, argument: presenter as PostDetailsInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(PostDetailsRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(PostDetailsInteractorInput.self) { (resolver, interactorOutput: PostDetailsInteractorOutput) in
            let userService = resolver.resolve(UserService.self).unwrap()
            let commentService = resolver.resolve(CommentService.self).unwrap()
            let postService = resolver.resolve(PostService.self).unwrap()
            let interactor = PostDetailsInteractor(userService: userService,
                                                   commentService: commentService,
                                                   postService: postService)
            interactor.output = interactorOutput
            return interactor
        }
    }
}
