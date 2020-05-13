//
//  MenuCellControllerFactory.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuCellControllerFactory

protocol MenuCellControllerFactory {
    
    /// Create MenuCellController instance using some
    /// viewModel and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModel: viewModel instance for cell's configuration
    ///   - tableView: tableView for registering cell
    /// - Returns: MenuCellController instance
    func controller(with viewModel: MenuCellViewModelProtocol, tableView: UITableView) -> MenuCellController
}

extension MenuCellControllerFactory {

    /// Create MenuCellController array using some
    /// viewModels and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModels: viewModels instances for cells configuration
    ///   - tableView: tableView for registering cells
    /// - Returns: MenuCellController array
    func controllers(with viewModels: [MenuCellViewModelProtocol], tableView: UITableView) -> [MenuCellController] {
        return viewModels.map {
            controller(with: $0, tableView: tableView)
        }
    }
}
