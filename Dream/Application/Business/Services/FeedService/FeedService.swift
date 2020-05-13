//
//  FeedService.swift
//  Dream
//
//  Created by denis on 08.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

typealias Feed = [PostPlainObject]
typealias ObtainFeedSuccess = (Feed) -> ()
typealias ObtainFeedFailure = (String) -> ()

protocol FeedService {
    
    func obtainFeed(success: @escaping ObtainFeedSuccess, failure: @escaping ObtainFeedFailure)
    
}
