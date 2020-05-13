//
//  CollectionContentManager.swift
//  Мечта.ру
//

import UIKit

// MARK: - CollectionContentManager

protocol CollectionContentManager: class {
    
    /// Table with content
    var collectionView: UICollectionView? { get set }

    /// Returns collectionViewLayout for UICollectionView
    ///
    /// - Parameter collectionView: UICollectionView instance
    /// - Returns: collectionViewLayout for UICollectionView
    func collectionViewLayout() -> UICollectionViewLayout
    
    /// Setup current content manager with some UICollectionView
    ///
    /// - Parameter collectionView: UICollectionView for cards displaying
    func configure(withCollectionView collectionView: UICollectionView)
}

extension CollectionContentManager {
 
    /// Setup current content manager with some UICollectionView
    ///
    /// - Parameter collectionView: UICollectionView for cards displaying
    func configure(withCollectionView collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
}
