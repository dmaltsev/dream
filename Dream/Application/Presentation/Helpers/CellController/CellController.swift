//
//  CellController.swift
//  Мечта.ру
//

import UIKit

// MARK: - CellController

class CellController<T: ReusableCellHolder>: NSObject {
    
    weak var reusableCellHolder: T?
    var indexPath: IndexPath?
    
    override init() {
    }
    
    class var cellClass: AnyClass {
        fatalError("Must be overriden by children.")
    }
    
    var cellObject: Any? {
        return nil
    }
    
    static var cellIdentifier: String {
        return String(describing: cellClass)
    }
    
    static func registerCell(on reusableCellHolder: T) {
        let bundle = Bundle(for: cellClass)
        if bundle.path(forResource: cellIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellIdentifier, bundle: bundle)
            reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        } else {
            reusableCellHolder.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
    func createCell() -> T.CellType? {
        return nil
    }
    
    final func cellFromReusableCellHolder(_ reusableCellHolder: T, forIndexPath indexPath: IndexPath) -> T.CellType {
        self.reusableCellHolder = reusableCellHolder
        self.indexPath = indexPath
        let cell = createCell() ?? reusableCellHolder.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath)
        configureCell(cell)
        return cell
    }
    
    final func innerCurrentCell() -> T.CellType? {
        guard let indexPath = indexPath else { return nil }
        return reusableCellHolder?.cellForItem(at: indexPath)
    }
    
    func configureCell(_ cell: T.CellType) {
        
    }
    
    func willDisplayCell(_ cell: T.CellType) {
        
    }
    
    func didEndDisplayingCell(_ cell: T.CellType) {
        
    }
    
    func didSelectCell() {
        
    }
    
    func didDeselectCell() {
        
    }
    
    func shouldHighlightCell() -> Bool {
        return true
    }
    
    func didHightlightCell() {
        
    }
    
    func didUnhightlightCell() {
        
    }
    
    func cellSize(reusableCellHolder: T) -> CGSize {
        fatalError("Must be overriden by children.")
    }
    
    func estimatedCellSize(reusableCellHolder: T) -> CGSize {
        fatalError("Must be overriden by children.")
    }
}
