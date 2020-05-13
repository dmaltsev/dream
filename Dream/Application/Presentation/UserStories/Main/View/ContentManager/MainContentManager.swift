//
//  MainContentManager.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainContentManager

protocol MainContentManager: CollectionContentManager {
    
    /// Update table's data using some new viewModels
    ///
    /// - Parameter viewModels: new data
    func updateData(_ viewModels: [GoodieCellModel])
}
