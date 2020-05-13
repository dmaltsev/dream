//
//  MenuContentManagerImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuContentManager

class MenuContentManagerImplementation: NSObject, MenuContentManager {
    
    // MARK: - Properties
    
    /// Menu controllers factory
    fileprivate let controllersFactory: MenuCellControllerFactory
    
    /// Current controllers which manipulates tableView's cells
    fileprivate var controllers: [TableCellController] = []

    /// UITableView with Menu cells
    var tableView: UITableView?
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter controllersFactory: menu controllers factory
    init(controllersFactory: MenuCellControllerFactory) {
        self.controllersFactory = controllersFactory
        super.init()
    }

    // MARK: - ContentManager

    func dataSource(for tableView: UITableView) -> UITableViewDataSource {
        return self
    }

    func delegate(for tableView: UITableView) -> UITableViewDelegate {
        return self
    }

    func updateData(_ viewModels: [MenuCellViewModelProtocol]) {
        guard let tableView = tableView else {
            return
        }
        controllers = controllersFactory.controllers(with: viewModels, tableView: tableView)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension MenuContentManagerImplementation: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}

// MARK: - UITableViewDataSource

extension MenuContentManagerImplementation: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = controllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
        return cell
    }
}
