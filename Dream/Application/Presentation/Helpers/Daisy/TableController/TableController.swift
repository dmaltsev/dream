//
//  TableController.swift
//

import UIKit

// MARK: - Notification.Name

extension Notification.Name {
    static let customCellActionNotification = Notification.Name(rawValue: "TableCellActionNotificationName")
}

// MARK: - TableController

class TableController: NSObject {

    // MARK: - Properties
    
    /// Target tableView (where will be our cells)
    private(set) weak var tableView: UITableView?
    
    /// scrollView delegate instance
    private weak var scrollDelegate: UIScrollViewDelegate?
    
    /// Table sections
    fileprivate(set) var sections: [TableSection] = []
    
    /// Auxiliary object for cells registration
    fileprivate var cellRegisterer: TableCellRegisterer?
    
    /// Auxiliary object for calculating rows height
    private(set) var cellHeightCalculator: CellHeightCalculator?
    
    /// Sections index titles
    fileprivate var sectionsIndexTitlesIndexes: [Int]?
    
    /// NotificationCenter instance (for receiving custom actions)
    private let notificationCenter: NotificationCenter = .default
    
    /// Check if tableView is empty
    var isEmpty: Bool {
        return sections.isEmpty
    }
    
    // MARK: - Initializers
    
    /// Default iniitalizer
    ///
    /// - Parameters:
    ///   - tableView: target tableView (where will be our cells)
    ///   - scrollDelegate: scrollView delegate instance
    ///   - cellHeightCalculator: auxiliary object for calculating rows height
    init(tableView: UITableView, scrollDelegate: UIScrollViewDelegate? = nil, cellHeightCalculator: CellHeightCalculator?) {
        super.init()
        self.cellRegisterer = TableCellRegisterer(tableView: tableView)
        self.cellHeightCalculator = cellHeightCalculator
        self.scrollDelegate = scrollDelegate
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        notificationCenter.addObserver(self, selector: #selector(didReceiveAction), name: .customCellActionNotification, object: nil)
    }

    /// Convenience default initializer
    ///
    /// - Parameters:
    ///   - tableView: target tableView (where will be our cells)
    ///   - scrollDelegate: scrollView delegate instance
    ///   - automaticCellCalculation: true if need to use built-in cells height calculator
    convenience init(tableView: UITableView, scrollDelegate: UIScrollViewDelegate? = nil, automaticCellCalculation: Bool = false) {
        let heightCalculator: DaisyCellHeightCalculator? = automaticCellCalculation ? DaisyCellHeightCalculator(tableView: tableView) : nil
        self.init(tableView: tableView, scrollDelegate: scrollDelegate, cellHeightCalculator: heightCalculator)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Useful
    
    /// Reload tableView data
    func reload() {
        tableView?.reloadData()
    }
    
    /// Check if cell with the given indexPath contains the given action
    ///
    /// - Parameters:
    ///   - action: some action for checking
    ///   - indexPath: given indexPath
    /// - Returns: true if cell with the given indexPath contains the given action
    func hasAction(_ action: TableRowActionType, atIndexPath indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].rows[indexPath.row].has(action: action)
    }
    
    // MARK: - NSObject
    
    override func responds(to selector: Selector) -> Bool {
        return super.responds(to: selector) || scrollDelegate?.responds(to: selector) == true
    }

    override func forwardingTarget(for selector: Selector) -> Any? {
        return scrollDelegate?.responds(to: selector) == true ? scrollDelegate : super.forwardingTarget(for: selector)
    }
    
    // MARK: - Private
    
    /// Call the given action for the given cell
    ///
    /// - Parameters:
    ///   - action: some necessary action
    ///   - cell: cell for the action
    ///   - indexPath: cell's indePath
    /// - Returns: action's output data
    @discardableResult fileprivate func call(action: TableRowActionType, cell: UITableViewCell?, indexPath: IndexPath) -> Any? {
        if indexPath.section < sections.count && indexPath.row < sections[indexPath.section].rows.count {
            return sections[indexPath.section].rows[indexPath.row].call(action: action, cell: cell, path: indexPath)
        }
        return nil
    }
    
    /// Auxuliary method for receiving custom actions
    ///
    /// - Parameter notification: notification with an action info
    @objc private func didReceiveAction(_ notification: Notification) {
        guard let action = notification.object as? TableCellAction, let indexPath = tableView?.indexPath(for: action.cell) else { return }
        call(action: .custom(action.id), cell: action.cell, indexPath: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension TableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.footerHeight ?? CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerHeight ?? CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        if cellHeightCalculator != nil {
            cellRegisterer?.register(cellType: row.cellType, forCellReuseIdentifier: row.reuseIdentifier)
        }
        return row.defaultHeight ?? row.estimatedHeight ?? cellHeightCalculator?.estimatedHeight(forRow: row, at: indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        if cellHeightCalculator != nil {
            cellRegisterer?.register(cellType: row.cellType, forCellReuseIdentifier: row.reuseIdentifier)
        }
        let cellHeight = call(action: .height, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? CGFloat
        return cellHeight ?? row.defaultHeight ?? cellHeightCalculator?.height(forRow: row, at: indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerHeight ?? section.headerView?.frame.size.height ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.footerHeight ?? section.footerView?.frame.size.height ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if call(action: .click, cell: cell, indexPath: indexPath) != nil {
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            call(action: .select, cell: cell, indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        call(action: .accessory, cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        call(action: .deselect, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        call(action: .willDisplay, cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        call(action: .didEndDisplaying, cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return call(action: .shouldHighlight, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? Bool ?? true
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if hasAction(.willSelect, atIndexPath: indexPath) {
            return call(action: .willSelect, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? IndexPath
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return sections[indexPath.section].rows[indexPath.row].editingActions
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if call(action: .canDelete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? Bool ?? false {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return call(action: .canMoveTo, cell: tableView.cellForRow(at: sourceIndexPath), indexPath: sourceIndexPath) as? IndexPath ?? proposedDestinationIndexPath
    }
}

// MARK: - UITableViewDataSource

extension TableController: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var indexTitles: [String] = []
        var indexTitlesIndexes: [Int] = []
        sections.enumerated().forEach { (index, section) in
            if let title = section.indexTitle {
                indexTitles.append(title)
                indexTitlesIndexes.append(index)
            }
        }
        if !indexTitles.isEmpty {
            sectionsIndexTitlesIndexes = indexTitlesIndexes
            return indexTitles
        }
        sectionsIndexTitlesIndexes = nil
        return nil
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sectionsIndexTitlesIndexes?[index] ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        cellRegisterer?.register(cellType: row.cellType, forCellReuseIdentifier: row.reuseIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.configure(cell)
        call(action: .configure, cell: cell, indexPath: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footerTitle
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].rows[indexPath.row].isEditingAllowed(forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return call(action: .canMove, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath) as? Bool ?? false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            call(action: .delete, cell: tableView.cellForRow(at: indexPath), indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        call(action: .move, cell: tableView.cellForRow(at: sourceIndexPath), indexPath: sourceIndexPath)
    }
}

// MARK: - Append/Insert/Remove etc.

extension TableController {

    @discardableResult func append(section: TableSection) -> Self {
        append(sections: [section])
        return self
    }
    
    @discardableResult func append(sections: [TableSection]) -> Self {
        self.sections.append(contentsOf: sections)
        return self
    }
    
    @discardableResult func append(rows: [TableRow]) -> Self {
        append(section: TableSection(rows: rows))
        return self
    }
    
    @discardableResult func append(row: TableRow) -> Self {
        append(rows: [row])
        return self
    }
    
    @discardableResult func insert(section: TableSection, atIndex index: Int) -> Self {
        sections.insert(section, at: index)
        return self
    }
    
    @discardableResult func replaceSection(at index: Int, with section: TableSection) -> Self {
        if index < sections.count {
            sections[index] = section
        }
        return self
    }
    
    @discardableResult func delete(sectionAt index: Int) -> Self {
        sections.remove(at: index)
        return self
    }
    
    @discardableResult func remove(sectionAt index: Int) -> Self {
        return delete(sectionAt: index)
    }
    
    @discardableResult func clear() -> Self {
        cellHeightCalculator?.invalidate()
        sections.removeAll()
        return self
    }
}
