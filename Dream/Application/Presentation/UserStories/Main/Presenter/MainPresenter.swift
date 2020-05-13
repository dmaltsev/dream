//
//  MainPresenter.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainPresenter

class MainPresenter {
    
    // MARK: - Properties
    
    /// View instance
    weak var view: MainViewInput?

    /// MainCellViewModelProtocol factory
    fileprivate let cardCellViewModelDesigner: CardCellViewModelDesigner
    
    /// Interactor instance
    var interactor: MainInteractorInput?

    /// Router instance
    var router: MainRouterInput?
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter cardCellViewModelDesigner: CardCellViewModelProtocol factory
    init(cardCellViewModelDesigner: CardCellViewModelDesigner) {
        self.cardCellViewModelDesigner = cardCellViewModelDesigner
    }
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    
    func didTriggerViewReadyEvent() {
        view?.setupInitialState()
        interactor?.obtainFeed()
    }
    
    func didTriggerOpenNewRequest() {
        router?.openNewRequest()
    }
    
    func didTriggerObtainFeed() {
        interactor?.obtainFeed()
    }
    
    func didTriggerOpenPostDetails(_ post: PostPlainObject) {
        router?.openPostDetails(post)
    }
}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    
    func obtainFeedSuccess(_ feed: [PostPlainObject]) {
        let viewModels: [GoodieCellModel] = feed.map { post -> GoodieCellModel in
            let mediaList:[GoodieCellViewModelProtocol] = post.mediaList.map { media -> GoodieCellViewModelProtocol in
                return GoodieCellViewModel(id: 0, media: media, post: post)
            }
            return GoodieCellModel(headerViewModel: GoodieHeaderCellViewModel(id: 0, post: post),
                            viewModels: mediaList )
        }
        view?.update(viewModels)
    }
    
    func processErrorMessage(_ errorMessage: String) {
        view?.stopIndication()
        view?.showErrorMessage(errorMessage)
    }
}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {
    
    
}
