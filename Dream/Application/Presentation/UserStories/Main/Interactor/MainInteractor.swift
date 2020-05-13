//
//  MainInteractor.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainInteractor

class MainInteractor {
    
    // MARK: - Properties
    
    private let feedService: FeedService
    
    /// Presenter instance
    weak var output: MainInteractorOutput?
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {
    
    func obtainFeed() {
        self.feedService.obtainFeed(success: { [weak self] feed in
            self?.output?.obtainFeedSuccess(feed)
        }) { [weak self] error in
            self?.output?.processErrorMessage(error)
        }
    }
    
}
