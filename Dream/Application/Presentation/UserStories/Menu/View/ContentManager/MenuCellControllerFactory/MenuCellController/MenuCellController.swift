//
//  MenuCellController.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MenuCellController

class MenuCellController: GenericCellController<MenuCell> {
    
    // MARK: - Properties
    
    /// ViewModel instance
    private let viewModel: MenuCellViewModelProtocol
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter viewModel: ViewModel instance
    init(viewModel: MenuCellViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - CellController
    
    override func configureCell(_ cell: MenuCell) {
        cell.setup(with: viewModel)
    }
}
