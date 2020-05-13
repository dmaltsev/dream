//
//  CommentsPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CommentsPresenter

class CommentsPresenter {
    
    // MARK: - Properties
    
    /// View instance
    weak var view: CommentsViewInput?

    /// CommentsCellViewModelProtocol factory
    fileprivate let commentCellViewModelDesigner: CommentCellViewModelDesigner
    
    /// Interactor instance
    var interactor: CommentsInteractorInput?

    /// Router instance
    var router: CommentsRouterInput?
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter commentCellViewModelDesigner: CommentCellViewModelProtocol factory
    init(commentCellViewModelDesigner: CommentCellViewModelDesigner) {
        self.commentCellViewModelDesigner = commentCellViewModelDesigner
    }
}

// MARK: - CommentsViewOutput

extension CommentsPresenter: CommentsViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState()
    }
}

// MARK: - CommentsInteractorOutput

extension CommentsPresenter: CommentsInteractorOutput {
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - CommentsModuleInput

extension CommentsPresenter: CommentsModuleInput {
    
    
}
