//
//  CommentsRouter.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CommentsRouter

class CommentsRouter {
    
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

// MARK: - CommentsRouterInput

extension CommentsRouter: CommentsRouterInput {
    
    func close() {
        transitionHandler?.closeCurrentModule(animated: true)
    }
}
