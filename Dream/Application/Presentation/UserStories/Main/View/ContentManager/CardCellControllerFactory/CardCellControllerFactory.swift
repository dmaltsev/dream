//
//  CardCellControllerFactory.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CardCellControllerFactory

protocol CardCellControllerFactory {
    
    /// Create CardCellController instance using some
    /// viewModel and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModel: viewModel instance for cell's configuration
    ///   - tableView: tableView for registering cell
    /// - Returns: CardCellController instance
    func controller(with viewModel: CardCellViewModelProtocol, tableView: UITableView) -> CardCellController
}

extension CardCellControllerFactory {

    /// Create CardCellController array using some
    /// viewModels and register it to the given tableView
    ///
    /// - Parameters:
    ///   - viewModels: viewModels instances for cells configuration
    ///   - tableView: tableView for registering cells
    /// - Returns: CardCellController array
    func controllers(with viewModels: [CardCellViewModelProtocol], tableView: UITableView) -> [CardCellController] {
        return viewModels.map {
            controller(with: $0, tableView: tableView)
        }
    }
}
