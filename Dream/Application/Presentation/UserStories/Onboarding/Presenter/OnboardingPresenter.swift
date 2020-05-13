//
//  OnboardingPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - OnboardingPresenter

class OnboardingPresenter {
    
    // MARK: - Properties
    
    /// View instance
    weak var view: OnboardingViewInput?

    /// Interactor instance
    var interactor: OnboardingInteractorInput?

    /// Router instance
    var router: OnboardingRouterInput?
}

// MARK: - OnboardingViewOutput

extension OnboardingPresenter: OnboardingViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState()
        UserDefaults.standard.setOnboardingShowed(true)
    }
    
    func didTriggerOpenMain() {
        router?.openMain()
    }
}

// MARK: - OnboardingInteractorOutput

extension OnboardingPresenter: OnboardingInteractorOutput {
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - OnboardingModuleInput

extension OnboardingPresenter: OnboardingModuleInput {
    
    
}
