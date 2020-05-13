//
//  MenuContentManager.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MenuContentManager

protocol MenuContentManager: ContentManager {
    
    /// Update table's data using some new viewModels
    ///
    /// - Parameter viewModels: new data
    func updateData(_ viewModels: [MenuCellViewModelProtocol])
}
