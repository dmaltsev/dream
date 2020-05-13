//
//  PostDetailsInteractor.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostDetailsInteractor

class PostDetailsInteractor {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    private let userService: UserService
    
    private let commentService: CommentService
    
    private let postService: PostService
    
    /// Presenter instance
    weak var output: PostDetailsInteractorOutput?
    
    init(userService: UserService, commentService: CommentService, postService: PostService) {
        self.userService = userService
        self.commentService = commentService
        self.postService = postService
    }
}

// MARK: - PostDetailsInteractorInput

extension PostDetailsInteractor: PostDetailsInteractorInput {
    
    func obtainUser(_ id: String) {
        userService.obtainUser(withUserId: id)
            .do(onNext: { [weak self] user in
                self?.output?.obtainUserSuccess(user)
            }).subscribe().disposed(by: disposeBag)
    }
    
    func createPostComment(forPostWithId id: String, comment: String) {
        commentService.postComment(forPostWithId: id, comment: comment)
            .do(onNext: { [weak self] comment in
                if let comment = comment {
                    self?.output?.postCommentSuccess(comment)
                } else {
                    self?.output?.processErrorMessage("")
                }
            }).subscribe().disposed(by: disposeBag)
    }
    
    func obtainPostComments(forPostWithId id: String) {
        commentService.obtainComments(forPostWithId: id)
            .do(onNext: { [weak self] comments in
                self?.output?.obtainComments(comments)
            }).subscribe().disposed(by: disposeBag)
    }
    
    func vote(forPostWithId id: String, forMediaWithId mediaId: String) {
        postService.vote(forPostWithId: id, forMediaWithId: mediaId)
            .do(onNext: { [weak self] _ in
                self?.output?.voteSuccess()
            }).subscribe().disposed(by: disposeBag)
    }
    
}
