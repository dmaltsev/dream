//
//  CardCellController.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CardCellController

class CardCellController: GenericCellController<CardCell> {
    
    // MARK: - Properties
    
    /// ViewModel instance
    private let viewModel: CardCellViewModelProtocol
    
    /// MainRouter instance
    private weak var mainRouter: MainRouterInput?

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter viewModel: ViewModel instance
    init(viewModel: CardCellViewModelProtocol, mainRouter: MainRouterInput) {
        self.viewModel = viewModel
        self.mainRouter = mainRouter
    }
    
    // MARK: - CellController
    
    override func configureCell(_ cell: CardCell) {
        cell.setup(with: viewModel)
    }
}
