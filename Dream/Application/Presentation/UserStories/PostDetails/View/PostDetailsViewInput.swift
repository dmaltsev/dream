//
//  PostDetailsViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - PostDetailsViewInput

protocol PostDetailsViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState(withPost post: PostPlainObject?)
    
    func update(_ viewModels: [CommentCellViewModelProtocol])
    
    func update(withUser user: UserPlainObject?)
}
