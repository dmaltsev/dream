//
//  MediaBrandViewOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MediaBrandViewOutput

protocol MediaBrandViewOutput {
    
    /// View is ready
    func didTriggerViewReadyEvent()
    
    func didTriggerConfirmBrand(_ brand: String)
}
