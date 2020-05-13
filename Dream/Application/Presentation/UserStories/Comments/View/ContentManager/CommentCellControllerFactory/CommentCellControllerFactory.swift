//
//  CommentCellControllerFactory.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentCellControllerFactory

protocol CommentCellControllerFactory {
    
    /// Create CommentCellController instance using some
    /// viewModel and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModel: viewModel instance for cell's configuration
    ///   - tableView: tableView for registering cell
    /// - Returns: CommentCellController instance
    func controller(with viewModel: CommentCellViewModelProtocol, tableView: UITableView) -> CommentCellController
}

extension CommentCellControllerFactory {

    /// Create CommentCellController array using some
    /// viewModels and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModels: viewModels instances for cells configuration
    ///   - tableView: tableView for registering cells
    /// - Returns: CommentCellController array
    func controllers(with viewModels: [CommentCellViewModelProtocol], tableView: UITableView) -> [CommentCellController] {
        return viewModels.map {
            controller(with: $0, tableView: tableView)
        }
    }
}
