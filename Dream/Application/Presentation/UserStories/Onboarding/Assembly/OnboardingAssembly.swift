//
//  OnboardingAssembly.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import Swinject

class OnboardingModuleAssembly: CollectableAssembly {

    // MARK: - Initializers
    
    required init() {

    }

    // MARK: - Useful

    func obtainViewController() -> OnboardingViewController {
        return unwrap(container.resolve(OnboardingViewController.self))
    }
    
    func configureModuleForViewInput(viewInput: OnboardingViewController) {
        viewInput.output = container.resolve(OnboardingViewOutput.self, argument: viewInput as OnboardingViewInput)
    }
    
    // MARK: - Assembly
    
    func assemble(inContainer container: Container) {

        container.register(OnboardingViewController.self) { resolver in
            let controller = OnboardingViewController()
            controller.output = resolver.resolve(OnboardingViewOutput.self, argument: controller as OnboardingViewInput)
            return controller
        }
        
        container.register(OnboardingRouterInput.self) { (resolver, transitionHandler: TransitionHandler) in
            let router = OnboardingRouter(transitionHandler: transitionHandler)    
            return router
        }
        
        container.register(OnboardingViewOutput.self) { (resolver, view: OnboardingViewInput) in
            let presenter = OnboardingPresenter()
            presenter.view = view
            return presenter
        }.initCompleted { (resolver, viewOutput) in
            if let presenter = viewOutput as? OnboardingPresenter {
                presenter.interactor = resolver.resolve(OnboardingInteractorInput.self, argument: presenter as OnboardingInteractorOutput)
                if let transitionHandler = presenter.view as? TransitionHandler {
                    presenter.router = resolver.resolve(OnboardingRouterInput.self, argument: transitionHandler)
                }
            }
        }
        
        container.register(OnboardingInteractorInput.self) { (resolver, interactorOutput: OnboardingInteractorOutput) in
            let interactor = OnboardingInteractor()
            interactor.output = interactorOutput
            return interactor
        }
    }
}