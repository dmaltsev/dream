//
//  TableRow.swift
//

import UIKit

// MARK: - TableRow

protocol TableRow {
    
    /// Unique hash
    var hashValue: Int { get }
    
    /// Cell reuse identifier
    var reuseIdentifier: String { get }
    
    /// Cell "generic" type
    var cellType: AnyClass { get }

    /// Estimated cell height
    var estimatedHeight: CGFloat? { get }
    
    /// Default cell height
    var defaultHeight: CGFloat? { get }
    
    /// All available editing actions (delete, move, etc.)
    var editingActions: [UITableViewRowAction]? { get }
    
    /// Configure some cell
    ///
    /// - Parameter cell: configurable cell
    func configure(_ cell: UITableViewCell)
    
    /// Check if editing is allowed
    ///
    /// - Parameter indexPath: cell's indexPath
    /// - Returns: true if editing is allowed
    func isEditingAllowed(forIndexPath indexPath: IndexPath) -> Bool
    
    /// Call some cell action
    ///
    /// - Parameters:
    ///   - action: given action
    ///   - cell: cell for action
    ///   - path: indexPath for the given cell
    /// - Returns: some action's value
    func call(action: TableRowActionType, cell: UITableViewCell?, path: IndexPath) -> Any?
    
    /// Check if row has the given action
    ///
    /// - Parameter action: some action
    /// - Returns:
    func has(action: TableRowActionType) -> Bool
}
