//
//  CommentCellController.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CommentCellController

class CommentCellController: GenericCellController<CommentCell> {
    
    // MARK: - Properties
    
    /// ViewModel instance
    private let viewModel: CommentCellViewModelProtocol
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter viewModel: ViewModel instance
    init(viewModel: CommentCellViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - CellController
    
    override func configureCell(_ cell: CommentCell) {
        cell.setup(with: viewModel)
    }
}
