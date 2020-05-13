//
//  NewRequestRouterInput.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - NewRequestRouterInput

protocol NewRequestRouterInput {
    
    /// Close current module
    func close()
    
    func openMediaBrand(withMediaImage image: UIImage, andModuleOutput output: MediaBrandModuleOutput)
}
