//
//  GenericCellController.swift
//  Мечта.ру
//

import UIKit

// MARK: - GenericCellController

typealias TableCellController = CellController<UITableView>
typealias CollectionCellController = CellController<UICollectionView>

class GenericCellController<T: ReusableCell> : CellController<T.CellHolder> {
    
    final override class var cellClass: AnyClass {
        return T.self
    }
    
    final override func configureCell(_ cell: T.CellHolder.CellType) {
        guard let cell = cell as? T else {
            fatalError("Cell of \(T.CellHolder.CellType.self) must be \(T.self)")
        }
        configureCell(cell)
    }
    
    final func currentCell() -> T? {
        return innerCurrentCell() as? T
    }
    
    final override func willDisplayCell(_ cell: T.CellHolder.CellType) {
        guard let cell = cell as? T else {
            fatalError("Cell of \(T.CellHolder.CellType.self) must be \(T.self)")
            return
        }
        willDisplayCell(cell)
    }
    
    final override func didEndDisplayingCell(_ cell: T.CellHolder.CellType) {
        guard let cell = cell as? T else {
//            fatalError("Cell of \(T.CellHolder.CellType.self) must be \(T.self)")
            log.error("Cell of \(T.CellHolder.CellType.self) must be \(T.self)")
            return
        }
        didEndDisplayingCell(cell)
    }
    
    func configureCell(_ cell: T) {

    }
    
    func willDisplayCell(_ cell: T) {

    }
    
    func didEndDisplayingCell(_ cell: T) {

    }
}
