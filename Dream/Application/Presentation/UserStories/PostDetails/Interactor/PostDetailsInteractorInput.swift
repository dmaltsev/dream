//
//  PostDetailsInteractorInput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - PostDetailsInteractorInput

protocol PostDetailsInteractorInput {
    
    func obtainUser(_ id: String)
    
    func obtainPostComments(forPostWithId id: String)
    
    func createPostComment(forPostWithId id: String, comment: String)
    
    func vote(forPostWithId id: String, forMediaWithId mediaId: String)
    
}
