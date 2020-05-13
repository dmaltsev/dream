//
//  TableCellRegisterer.swift
//

import UIKit

// MARK: - TableCellRegisterer

class TableCellRegisterer {

    /// All registered cell identiifers
    private var registeredIds = Set<String>()
    
    /// Target tableView instance
    private weak var tableView: UITableView?
    
    /// Default initialzier
    ///
    /// - Parameter tableView: target tableView instance
    init(tableView: UITableView?) {
        self.tableView = tableView
    }
    
    /// Register some cell type to the tableView
    ///
    /// - Parameters:
    ///   - cellType: some cell type
    ///   - reuseIdentifier: cell's reuse identifier
    func register(cellType: AnyClass, forCellReuseIdentifier reuseIdentifier: String) {
        if registeredIds.contains(reuseIdentifier) {
            return
        }
        if tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier) != nil {
            registeredIds.insert(reuseIdentifier)
            return
        }
        let bundle = Bundle(for: cellType)
        if let _ = bundle.path(forResource: reuseIdentifier, ofType: "nib") {
            tableView?.register(UINib(nibName: reuseIdentifier, bundle: bundle), forCellReuseIdentifier: reuseIdentifier)
        } else {
            tableView?.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
        registeredIds.insert(reuseIdentifier)
    }
}
