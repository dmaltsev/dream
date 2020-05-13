//
//  MainViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

// MARK: - MainViewInput

protocol MainViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState()
    
    /// Update data
    ///
    /// - Parameter viewModels: new data for UITableView instance
    func update(_ viewModels: [GoodieCellModel])
}
