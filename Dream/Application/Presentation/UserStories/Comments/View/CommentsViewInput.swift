//
//  CommentsViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - CommentsViewInput

protocol CommentsViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState()
    
    /// Update data
    ///
    /// - Parameter viewModels: new data for UITableView instance
    func update(_ viewModels: [CommentCellViewModelProtocol])
}
