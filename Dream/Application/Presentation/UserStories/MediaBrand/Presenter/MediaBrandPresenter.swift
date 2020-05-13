//
//  MediaBrandPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MediaBrandPresenter

class MediaBrandPresenter {
    
    // MARK: - Properties
    private var image: UIImage?
    
    /// View instance
    weak var view: MediaBrandViewInput?
    
    weak var output: MediaBrandModuleOutput?

    /// Interactor instance
    var interactor: MediaBrandInteractorInput?

    /// Router instance
    var router: MediaBrandRouterInput?
}

// MARK: - MediaBrandViewOutput

extension MediaBrandPresenter: MediaBrandViewOutput {
    
    func didTriggerConfirmBrand(_ brand: String) {
        self.output?.setBrand(brand, withImage: image)
        self.router?.close()
    }
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState(withImage: image)
    }
}

// MARK: - MediaBrandInteractorOutput

extension MediaBrandPresenter: MediaBrandInteractorOutput {
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - MediaBrandModuleInput

extension MediaBrandPresenter: MediaBrandModuleInput {
    
    func setMediaImage(_ image: UIImage) {
        self.image = image
    }
    
    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        self.output = moduleOutput as? MediaBrandModuleOutput
    }
}
