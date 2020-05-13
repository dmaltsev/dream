//
//  ContentManager.swift
//  Мечта.ру
//

import UIKit

// MARK: - ContentManager

protocol ContentManager: class {
    
    /// Table with content
    var tableView: UITableView? { get set }

    /// Returns dataSource for UITableView
    ///
    /// - Parameter tableView: UITableView instance
    /// - Returns: dataSource for UITableView
    func dataSource(`for` tableView: UITableView) -> UITableViewDataSource

    /// Returns delegate for UITableView
    ///
    /// - Parameter tableView: UITableView instance
    /// - Returns: delegate for UITableView
    func delegate(`for` tableView: UITableView) -> UITableViewDelegate
    
    /// Setup current content manager with some UITableView
    ///
    /// - Parameter tableView: UITableView for cards displaying
    func configure(withTableView tableView: UITableView)
}

extension ContentManager {
 
    /// Setup current content manager with some UITableView
    ///
    /// - Parameter tableView: UITableView for cards displaying
    func configure(withTableView tableView: UITableView) {
        tableView.dataSource = dataSource(for: tableView)
        tableView.delegate = delegate(for: tableView)
        self.tableView = tableView
    }
}
