//
//  TableSection.swift
//

import UIKit

// MARK: - TableSection

class TableSection {
    
    // MARK: - Properties
    
    private(set) var rows: [TableRow] = []

    var headerTitle: String?
    var footerTitle: String?
    var indexTitle: String?
    
    var headerView: UIView?
    var footerView: UIView?
    
    var headerHeight: CGFloat? = nil
    var footerHeight: CGFloat? = nil
    
    var numberOfRows: Int {
        return rows.count
    }
    
    var isEmpty: Bool {
        return rows.isEmpty
    }
    
    // MARK: - Initializers
    
    /// Default iniitalizer
    ///
    /// - Parameter rows: section rows
    init(rows: [TableRow]? = nil) {
        if let rows = rows {
            self.rows.append(contentsOf: rows)
        }
    }
    
    /// Initializer with header and footer titles
    ///
    /// - Parameters:
    ///   - headerTitle: header's title
    ///   - footerTitle: footer's title
    ///   - rows: section rows
    convenience init(headerTitle: String?, footerTitle: String?, rows: [TableRow]? = nil) {
        self.init(rows: rows)
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
    
    /// Initializer with header and footer views
    ///
    /// - Parameters:
    ///   - headerView: header's view
    ///   - footerView: footer's view
    ///   - rows: section rows
    convenience init(headerView: UIView?, footerView: UIView?, rows: [TableRow]? = nil) {
        self.init(rows: rows)
        self.headerView = headerView
        self.footerView = footerView
    }
    
    // MARK: - Useful
    
    /// Remove all rows in section
    func clear() {
        rows.removeAll()
    }
    
    /// Add row to the section
    ///
    /// - Parameter row: new row
    func append(row: TableRow) {
        append(rows: [row])
    }
    
    /// Add new rows to the section
    ///
    /// - Parameter rows: new rows
    func append(rows: [TableRow]) {
        self.rows.append(contentsOf: rows)
    }
    
    /// Insert some row at the given index
    ///
    /// - Parameters:
    ///   - row: new row
    ///   - index: index for the row
    func insert(row: TableRow, at index: Int) {
        rows.insert(row, at: index)
    }
    
    /// Insert some new rows at the given index
    ///
    /// - Parameters:
    ///   - rows: new rows
    ///   - index: index for new rows
    func insert(rows: [TableRow], at index: Int) {
        self.rows.insert(contentsOf: rows, at: index)
    }
    
    /// Replace some row with new row
    ///
    /// - Parameters:
    ///   - index: index for replacing
    ///   - row: new row
    func replaceRow(at index: Int, with row: TableRow) {
        rows[index] = row
    }
    
    /// Swap rows by its indexes
    ///
    /// - Parameters:
    ///   - from: first index
    ///   - to: second index
    func swap(from: Int, to: Int) {
        rows.swapAt(from, to)
    }
    
    /// Delete some row by index
    ///
    /// - Parameter index: index for deletion
    func deleteRow(at index: Int) {
        rows.remove(at: index)
    }
    
    /// Delete some row by index
    ///
    /// - Parameter index: index for deletion
    func removeRow(at index: Int) {
        rows.remove(at: index)
    }
}
