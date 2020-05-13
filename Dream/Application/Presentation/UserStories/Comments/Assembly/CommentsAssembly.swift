//
//  CommentsAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class CommentsModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> CommentsViewController {
        return unwrap(container.resolve(CommentsViewController.self))
    }

    func configureModuleForViewInput(viewInput: CommentsViewController) {
        viewInput.output = container.resolve(CommentsViewOutput.self, argument: viewInput as CommentsViewInput)
        viewInput.contentManager = container.resolve(CommentsContentManager.self)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(CommentsViewController.self) { resolver in
            let controller = CommentsViewController()
            controller.output = resolver.resolve(CommentsViewOutput.self, argument: controller as CommentsViewInput)
            controller.contentManager = resolver.resolve(CommentsContentManager.self)
            return controller
        }
        
        container.register(CommentsRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = CommentsRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(CommentsViewOutput.self) { (resolver, view: CommentsViewInput) in
            let commentCellViewModelDesigner = resolver.resolve(CommentCellViewModelDesigner.self).unwrap()
            let presenter = CommentsPresenter(commentCellViewModelDesigner: commentCellViewModelDesigner)
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? CommentsPresenter {
                presenter.interactor = resolver.resolve(CommentsInteractorInput.self, argument: presenter as CommentsInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(CommentsRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(CommentsInteractorInput.self) { (resolver, interactorOutput: CommentsInteractorOutput) in
            let interactor = CommentsInteractor()
            interactor.output = interactorOutput
            return interactor
        }
        
        container.register(CommentCellControllerFactory.self) { resolver in
            return CommentCellControllerFactoryImplementation()
        }
        
        container.register(CommentCellViewModelDesigner.self) { resolver in
            return CommentCellViewModelDesignerImplementation()
        }
            
        container.register(CommentsContentManager.self) { resolver in
            let contentManager = CommentsContentManagerImplementation()
            return contentManager
        }
    }
}
