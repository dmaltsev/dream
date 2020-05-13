//
//  PostDetailsPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - PostDetailsPresenter

class PostDetailsPresenter {
    
    // MARK: - Properties
    var post: PostPlainObject?
    
    /// View instance
    weak var view: PostDetailsViewInput?

    /// Interactor instance
    var interactor: PostDetailsInteractorInput?

    /// Router instance
    var router: PostDetailsRouterInput?
}

// MARK: - PostDetailsViewOutput

extension PostDetailsPresenter: PostDetailsViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState(withPost: post)
        didTriggeredObtainComments()
    }
    
    func didTriggeredObtainUser(_ id: String) {
        interactor?.obtainUser(id)
    }
    
    func didTriggeredObtainComments() {
        if let post = post {
            interactor?.obtainPostComments(forPostWithId: post.id)
        }
    }
    
    func didTriggeredPostComment(_ comment: String) {
        if let post = post {
            interactor?.createPostComment(forPostWithId: post.id, comment: comment)
        }
    }
    
    func didTriggeredVote(forMediaWithId mediaId: String) {
        if let post = post {
            view?.startIndication()
            interactor?.vote(forPostWithId: post.id, forMediaWithId: mediaId)
        }
    }
}

// MARK: - PostDetailsInteractorOutput

extension PostDetailsPresenter: PostDetailsInteractorOutput {
    
    func obtainUserSuccess(_ user: UserPlainObject?) {
        view?.update(withUser: user)
    }
    
    func obtainComments(_ comments: [CommentPlainObject]) {
        view?.update(comments.map { CommentCellViewModel(comment: $0) })
    }
    
    func postCommentSuccess(_ comment: CommentPlainObject) {
        didTriggeredObtainComments()
    }
    
    func voteSuccess() {
        view?.stopIndication()
    }
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - PostDetailsModuleInput

extension PostDetailsPresenter: PostDetailsModuleInput {
    
    func setPost(_ post: PostPlainObject?) {
        self.post = post
    }
    
}
