//
//  OnboardingRouter.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - OnboardingRouter

class OnboardingRouter {
    
	// MARK: - Properties
    
    /// Transition handler instance
    weak var transitionHandler: TransitionHandler?
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameter transitionHandler: transition handler instance
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - OnboardingRouterInput

extension OnboardingRouter: OnboardingRouterInput {
    
    func openMain() {
        transitionHandler?.openModule(MainModule.self)
            .to(preferredTransitionStyle: .navigationController(navigationStyle: .single))
            .then { input in
                
            }
    }
    
    func close() {
        transitionHandler?.closeCurrentModule(animated: true)
    }
}
