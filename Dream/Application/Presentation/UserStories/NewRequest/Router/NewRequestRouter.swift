//
//  NewRequestRouter.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - NewRequestRouter

class NewRequestRouter {
    
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

// MARK: - NewRequestRouterInput

extension NewRequestRouter: NewRequestRouterInput {
    
    func close() {
        transitionHandler?.closeCurrentModule(animated: true)
    }
    
    func openMediaBrand(withMediaImage image: UIImage, andModuleOutput output: MediaBrandModuleOutput) {
        transitionHandler?.openModule(MediaBrandModule.self)
            .to(preferredTransitionStyle: .navigationController(navigationStyle: .push))
            .then { input in
                input.setMediaImage(image)
                input.setModuleOutput(output)
            }
    }
}
