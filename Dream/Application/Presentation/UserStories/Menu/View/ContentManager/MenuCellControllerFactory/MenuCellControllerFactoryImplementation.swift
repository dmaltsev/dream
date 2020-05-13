//
//  MenuCellControllerFactoryImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MenuCellControllerFactoryImplementation

class MenuCellControllerFactoryImplementation {

}

// MARK: - MenuCellControllerFactory

extension MenuCellControllerFactoryImplementation: MenuCellControllerFactory {

    func controller(with viewModel: MenuCellViewModelProtocol, tableView: UITableView) -> MenuCellController {
        MenuCellController.registerCell(on: tableView)
        return MenuCellController(viewModel: viewModel)
    }
}
