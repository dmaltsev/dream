//
//  MediaBrandViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - MediaBrandViewInput

protocol MediaBrandViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState(withImage image: UIImage?)
}
