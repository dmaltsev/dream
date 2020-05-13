//
//  CommentCellControllerFactoryImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CommentCellControllerFactoryImplementation

class CommentCellControllerFactoryImplementation {

}

// MARK: - CommentCellControllerFactory

extension CommentCellControllerFactoryImplementation: CommentCellControllerFactory {

    func controller(with viewModel: CommentCellViewModelProtocol, tableView: UITableView) -> CommentCellController {
        CommentCellController.registerCell(on: tableView)
        return CommentCellController(viewModel: viewModel)
    }
}
