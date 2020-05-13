//
//  FeedServiceImplementation.swift
//  Dream
//
//  Created by denis on 08.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

class FeedServiceImplementation {
    
}

extension FeedServiceImplementation : FeedService {
    
    func obtainFeed(success: @escaping ObtainFeedSuccess, failure: @escaping ObtainFeedFailure) {
        let request = ApiRouter.getFeed
        ApiClient.sharedInstance.performRequest(request: request, responseHandler: { (response: GetFeedResponse) -> (Void) in
            success(response.feed)
        }) { error -> (Void) in
            failure(error.localizedDescription)
        }
    }
    
}
