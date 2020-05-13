//
//  OnboardingViewInput.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

// MARK: - OnboardingViewInput

protocol OnboardingViewInput: class, ViewInput {
    
    /// Setup initial view state
    func setupInitialState()
}