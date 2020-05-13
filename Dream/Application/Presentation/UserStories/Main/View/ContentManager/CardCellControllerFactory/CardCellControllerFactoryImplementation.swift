//
//  CardCellControllerFactoryImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Swinject

// MARK: - CardCellControllerFactoryImplementation

class CardCellControllerFactoryImplementation {

	// MARK: - Properties
    
    /// DI container instance
    fileprivate let container: Container
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameter container: DI container instance
    init(container: Container) {
        self.container = container
    }
}

// MARK: - CardCellControllerFactory

extension CardCellControllerFactoryImplementation: CardCellControllerFactory {

    func controller(with viewModel: CardCellViewModelProtocol, tableView: UITableView) -> CardCellController {
        CardCellController.registerCell(on: tableView)
        let mainRouter = container.resolve(MainRouterInput.self).unwrap()
        return CardCellController(viewModel: viewModel, mainRouter: mainRouter)
    }
}
