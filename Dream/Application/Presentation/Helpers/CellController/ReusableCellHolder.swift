//
//  ReusableCellHolder.swift
//  Мечта.ру
//

import UIKit

// MARK: - ReusableCell

protocol ReusableCell: class {
    associatedtype CellHolder: ReusableCellHolder
}

extension UITableViewCell: ReusableCell {
    typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
    typealias CellHolder = UICollectionView
}

// MARK: - ReusableCellHolder

protocol ReusableCellHolder: class {
    associatedtype CellType: ReusableCell where CellType.CellHolder == Self
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> CellType
    func cellForItem(at indexPath: IndexPath) -> CellType?
}

extension UITableView: ReusableCellHolder {
    
    @objc(registerNib:forCellWithReuseIdentifier:)
    func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }

    @objc(registerClass:forCellWithReuseIdentifier:)
    func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        register(cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

    func cellForItem(at indexPath: IndexPath) -> UITableViewCell? {
        return cellForRow(at: indexPath)
    }
}

extension UICollectionView: ReusableCellHolder {
    
}
