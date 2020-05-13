//
//  DaisyCellHeightCalculator.swift
//

import UIKit

// MARK: - DaisyCellHeightCalculator

class DaisyCellHeightCalculator {

    // MARK: - Properties
    
    /// Target tableView
    private(set) weak var tableView: UITableView?
    
    /// Cell prototypes
    fileprivate var cells: [String: UITableViewCell] = [:]
    
    /// Some predefined (cached) height for cells (saved by cell's hash value)
    fileprivate var cachedHeights: [Int: CGFloat] = [:]
    
    /// Table's separator height
    fileprivate var separatorHeight = 1 / UIScreen.main.scale

    // MARK: - Initializers
    
    /// Default initalizer
    ///
    /// - Parameter tableView: target tableView
    public init(tableView: UITableView?) {
        self.tableView = tableView
    }
}

// MARK: - CellHeightCalculator

extension DaisyCellHeightCalculator: CellHeightCalculator {
    
    func height(forRow row: TableRow, at indexPath: IndexPath) -> CGFloat {
        guard let tableView = tableView else {
            return 0
        }
        let hash = row.hashValue ^ Int(tableView.bounds.size.width).hashValue
        if let height = cachedHeights[hash] {
            return height
        }
        var prototypeCell = cells[row.reuseIdentifier]
        if prototypeCell == nil {
            prototypeCell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier)
            cells[row.reuseIdentifier] = prototypeCell
        }
        guard let cell = prototypeCell else {
            return 0
        }
        cell.prepareForReuse()
        row.configure(cell)
        cell.bounds = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: cell.bounds.height)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let height = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + (tableView.separatorStyle != .none ? separatorHeight : 0)
        cachedHeights[hash] = height
        return height
    }
    
    func estimatedHeight(forRow row: TableRow, at indexPath: IndexPath) -> CGFloat {
        guard let tableView = tableView else {
            return 0
        }
        let hash = row.hashValue ^ Int(tableView.bounds.size.width).hashValue
        if let height = cachedHeights[hash] {
            return height
        }
        if let estimatedHeight = row.estimatedHeight, estimatedHeight > 0 {
            return estimatedHeight
        }
        return UITableView.automaticDimension
    }
    
    func invalidate() {
        cachedHeights.removeAll()
    }
}
