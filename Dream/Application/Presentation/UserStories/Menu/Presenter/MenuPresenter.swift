//
//  MenuPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MenuPresenter

class MenuPresenter {
    
    // MARK: - Properties
    
    /// View instance
    weak var view: MenuViewInput?

    /// MenuCellViewModelProtocol factory
    fileprivate let menuCellViewModelDesigner: MenuCellViewModelDesigner
    
    /// Interactor instance
    var interactor: MenuInteractorInput?

    /// Router instance
    var router: MenuRouterInput?
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter menuCellViewModelDesigner: MenuCellViewModelProtocol factory
    init(menuCellViewModelDesigner: MenuCellViewModelDesigner) {
        self.menuCellViewModelDesigner = menuCellViewModelDesigner
    }
}

// MARK: - MenuViewOutput

extension MenuPresenter: MenuViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState()
        setupModels()
    }
    
    private func setupModels() {
        let viewModels: [MenuCellViewModelProtocol] = [
            MenuCellViewModel(icon: UIImage(named: "AllQuestions"), title: loc("menu.option.all")),
            MenuCellViewModel(icon: UIImage(named: "MyQuestions"), title: loc("menu.option.my")),
            MenuCellViewModel(icon: UIImage(named: "MyComments"), title: loc("menu.option.comments")),
            MenuCellViewModel(icon: UIImage(named: "Settings"), title: loc("menu.option.edit")),
            MenuCellViewModel(icon: UIImage(named: "NewQuestion"), title: loc("menu.option.new")),
            MenuCellViewModel(icon: UIImage(named: "About"), title: loc("menu.option.about"))
        ]
        view?.update(viewModels)
    }
}

// MARK: - MenuInteractorOutput

extension MenuPresenter: MenuInteractorOutput {
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - MenuModuleInput

extension MenuPresenter: MenuModuleInput {
    
    
}
