//
//  OnboardingViewOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - OnboardingViewOutput

protocol OnboardingViewOutput {
    
    /// View is ready
    func didTriggerViewReadyEvent()
    
    func didTriggerOpenMain()
}
