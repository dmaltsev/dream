//
//  MainRouter.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainRouter

class MainRouter {
    
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

// MARK: - MainRouterInput

extension MainRouter: MainRouterInput {
    
    func openNewRequest() {
        let controller = StartViewController(rootViewController: NewRequestModule.instantiateTransitionHandler())
        transitionHandler?.openModule(NewRequestModule.self, controller: controller)
            .to(preferredTransitionStyle: .present)
            .modalPresentationStyle(.fullScreen)
            .then { input in
                
            }
    }
    
    func openPostDetails(_ post: PostPlainObject) {
        transitionHandler?.openModule(PostDetailsModule.self)
            .to(preferredTransitionStyle: .navigationController(navigationStyle: .push))
            .then { input in
                input.setPost(post)
            }
    }
    
    func close() {
        transitionHandler?.closeCurrentModule(animated: true)
    }
}
