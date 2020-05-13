//
//  TableRowActionOptions.swift
//

import UIKit

// MARK: - TableRowActionOptions

class TableRowActionOptions<CellType: ConfigurableCell> where CellType: UITableViewCell {

    // MARK: - Properties
    
    /// Cell element instance
    let element: CellType.Element
    
    /// Cell's "generic" type
    let cell: CellType?
    
    /// Cell's indexPath
    let indexPath: IndexPath
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - element: cell's element instance
    ///   - cell: cell's "generic" type
    ///   - path: cell's indexPath
    init(element: CellType.Element, cell: CellType?, path: IndexPath) {
        self.element = element
        self.cell = cell
        self.indexPath = path
    }
}
