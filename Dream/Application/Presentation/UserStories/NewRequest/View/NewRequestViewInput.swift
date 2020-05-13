//
//  NewRequestViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - NewRequestViewInput

protocol NewRequestViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState()
    
    func update(brand: String, withImage image: UIImage?)
}
