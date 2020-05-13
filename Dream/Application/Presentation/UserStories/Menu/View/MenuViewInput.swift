//
//  MenuViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - MenuViewInput

protocol MenuViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState()
    
    /// Update data
    ///
    /// - Parameter viewModels: new data for UITableView instance
    func update(_ viewModels: [MenuCellViewModelProtocol])
}
