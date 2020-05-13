//
//  PostDetailsInteractorOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - PostDetailsInteractorOutput

protocol PostDetailsInteractorOutput: class, InteractorOutput {
    
    func obtainUserSuccess(_ user: UserPlainObject?)
    
    func obtainComments(_ comments: [CommentPlainObject])
    
    func postCommentSuccess(_ comment: CommentPlainObject)
    
    func voteSuccess()
    
}
