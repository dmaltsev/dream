//
//  OnboardingRouterInput.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - OnboardingRouterInput

protocol OnboardingRouterInput {
    
    /// Close current module
    func close()
    
    func openMain()
}
