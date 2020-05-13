//
//  TableRowAction.swift
//

import UIKit

// MARK: - TableRowAction

class TableRowAction<CellType: ConfigurableCell> where CellType: UITableViewCell {
    
    // MARK: - Properties
    
    /// Action id
    let id: String?
    
    /// Action type
    let type: TableRowActionType
    
    /// Action block
    private let action: (TableRowActionOptions<CellType>) -> Any?
    
    // MARK: - Initializers
    
    /// Default initializer with predefined action type
    ///
    /// - Parameters:
    ///   - type: action type
    ///   - action: action block
    init(_ type: TableRowActionType, action: @escaping (_ options: TableRowActionOptions<CellType>) -> Void) {
        self.type = type
        self.action = action
        id = nil
    }
    
    /// Default initializer with custom action type
    ///
    /// - Parameters:
    ///   - key: action type
    ///   - action: action block
    init(_ key: String, action: @escaping (_ options: TableRowActionOptions<CellType>) -> Void) {
        self.type = .custom(key)
        self.action = action
        id = nil
    }

    /// Default initializer with predefined action type
    ///
    /// - Parameters:
    ///   - type: action type
    ///   - action: action block
    init<T>(_ type: TableRowActionType, action: @escaping (_ options: TableRowActionOptions<CellType>) -> T) {
        self.type = type
        self.action = action
        id = nil
    }
    
    /// Call action block
    ///
    /// - Parameters:
    ///   - cell: target cell
    ///   - element: cell's element
    ///   - path: cell's indexPath
    /// - Returns: Action's return type
    func cellActionOn(cell: UITableViewCell?, element: CellType.Element, path: IndexPath) -> Any? {
        return action(TableRowActionOptions(element: element, cell: cell as? CellType, path: path))
    }
}
