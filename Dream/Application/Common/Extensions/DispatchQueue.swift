//
//  DispatchQueue.swift
//  Dream
//
//  Created by denis on 24/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Foundation

// MARK: - DispatchQueue

extension DispatchQueue {

    static let dispatchQueue = DispatchQueue(label: "ru.dream.dispatch", attributes: [])

    private static var onceTracker: [String] = []
    
    static func once(token: String, block: () -> Void) {
        
        objc_sync_enter(self)
        
        defer {
            objc_sync_exit(self)
        }
        
        if onceTracker.contains(token) {
            return
        }
        
        onceTracker.append(token)
        block()
    }
}
