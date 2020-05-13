//
//  Row.swift
//

import UIKit

// MARK: - Row

class Row<CellType: ConfigurableCell>: TableRow where CellType: UITableViewCell {

    // MARK: - Properties
    
    /// ViewModel instance
    let element: CellType.Element
    
    /// All active actions
    private var actions: [String: [TableRowAction<CellType>]] = [:]
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - element: element instance
    ///   - actions: some cell actions
    ///   - editingActions: some editing actions
    public init(element: CellType.Element, actions: [TableRowAction<CellType>]? = nil, editingActions: [UITableViewRowAction]? = nil) {
        self.element = element
        self.editingActions = editingActions
        actions?.forEach { on($0) }
    }
    
    // MARK: - TableRow
    
    private(set) var editingActions: [UITableViewRowAction]?
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }

    var reuseIdentifier: String {
        return CellType.reuseIdentifier
    }
    
    var estimatedHeight: CGFloat? {
        return CellType.estimatedHeight
    }
    
    var defaultHeight: CGFloat? {
        return CellType.defaultHeight
    }
    
    var cellType: AnyClass {
        return CellType.self
    }
    
    func configure(_ cell: UITableViewCell) {
        (cell as? CellType)?.configure(with: element)
    }
    
    func call(action: TableRowActionType, cell: UITableViewCell?, path: IndexPath) -> Any? {
        return actions[action.key]?.compactMap {
            $0.cellActionOn(cell: cell, element: element, path: path)
        }.last
    }
    
    func has(action: TableRowActionType) -> Bool {
        return actions[action.key] != nil
    }
    
    func isEditingAllowed(forIndexPath indexPath: IndexPath) -> Bool {
        if actions[TableRowActionType.canEdit.key] != nil {
            return call(action: .canEdit, cell: nil, path: indexPath) as? Bool ?? false
        }
        return editingActions?.isEmpty == false || actions[TableRowActionType.delete.key] != nil
    }
    
    // MARK: - Useful
    
    /// Add some new action
    ///
    /// - Parameter action: new action block
    /// - Returns: Current instance
    @discardableResult func on(_ action: TableRowAction<CellType>) -> Self {
        if actions[action.type.key] == nil {
            actions[action.type.key] = [TableRowAction<CellType>]()
        }
        actions[action.type.key]?.append(action)
        return self
    }
    
    /// Add some new action with predefined type
    ///
    /// - Parameters:
    ///   - type: action type (predefined)
    ///   - action: action block
    /// - Returns: Current instance
    @discardableResult func on<T>(_ type: TableRowActionType, action: @escaping (_ options: TableRowActionOptions<CellType>) -> T) -> Self {
        return on(TableRowAction<CellType>(type, action: action))
    }
    
    /// Add some new custom action
    ///
    /// - Parameters:
    ///   - key: action key (custom)
    ///   - action: action block
    /// - Returns: Current instance
    @discardableResult func on(_ key: String, action: @escaping (_ options: TableRowActionOptions<CellType>) -> ()) -> Self {
        return on(TableRowAction<CellType>(.custom(key), action: action))
    }
    
    /// Removw all available actions
    func removeAllActions() {
        actions.removeAll()
    }
    
    /// Remove the specified action
    ///
    /// - Parameter actionId: acton identifier
    func removeAction(forActionId actionId: String) {
        for (key, value) in actions {
            if let actionIndex = value.firstIndex(where: { $0.id == actionId }) {
                actions[key]?.remove(at: actionIndex)
            }
        }
    }
}
