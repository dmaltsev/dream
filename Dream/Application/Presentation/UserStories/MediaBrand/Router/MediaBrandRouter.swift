//
//  MediaBrandRouter.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MediaBrandRouter

class MediaBrandRouter {
    
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

// MARK: - MediaBrandRouterInput

extension MediaBrandRouter: MediaBrandRouterInput {
    
    func close() {
        transitionHandler?.closeCurrentModule(animated: true)
    }
}
