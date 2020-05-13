//
//  NewRequestPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - NewRequestPresenter

class NewRequestPresenter {
    
    // MARK: - Properties
    
    /// View instance
    weak var view: NewRequestViewInput?

    /// Interactor instance
    var interactor: NewRequestInteractorInput?

    /// Router instance
    var router: NewRequestRouterInput?
}

// MARK: - NewRequestViewOutput

extension NewRequestPresenter: NewRequestViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState()
    }
    
    func didTriggerCreatePost(name: String, age: Int, description: String, media: [UIImage]) {
        interactor?.createPost(name: name, age: age, description: description, media: media)
    }
    
    func didTriggerSetMediaBrand(withMediaImage image: UIImage) {
        self.router?.openMediaBrand(withMediaImage: image, andModuleOutput: self)
    }
}

// MARK: - NewRequestInteractorOutput

extension NewRequestPresenter: NewRequestInteractorOutput {
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - NewRequestModuleInput

extension NewRequestPresenter: NewRequestModuleInput {
    
    
}

// MARK: - MediaBrandModuleOutput

extension NewRequestPresenter: MediaBrandModuleOutput {
    
    func setBrand(_ brand: String, withImage image: UIImage?) {
        self.view?.update(brand: brand, withImage: image)
    }
    
}
