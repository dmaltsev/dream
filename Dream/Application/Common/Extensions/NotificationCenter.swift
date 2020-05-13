//
//  NotificationCenter.swift
//  Dream
//
//  Created by denis on 02.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

private extension Notification.Name {
    
    static let didPostComment = Notification.Name("didPostComment")
    static let didVoteMedia = Notification.Name("didVoteMedia")
    
}

extension NotificationCenter {
    
    func notifyPostComment(withComment comment: String) {
        self.post(name: .didPostComment, object: comment)
    }
    
    func observeOnPostComment(withObserver observer: Any, selector: Selector) {
        self.addObserver(observer, selector: selector, name: .didPostComment, object: nil)
    }
    
    func notifyVoteMedia(withMediaId mediaId: String) {
        self.post(name: .didVoteMedia, object: mediaId)
    }
    
    func observeOnVoteMedia(withObserver observer: Any, selector: Selector) {
        self.addObserver(observer, selector: selector, name: .didVoteMedia, object: nil)
    }
}
