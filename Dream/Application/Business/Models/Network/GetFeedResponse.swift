//
//  GetFeedResponse.swift
//  Dream
//
//  Created by denis on 09.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

class GetFeedResponse : BaseNetworkResponse {
    
    var feed: [PostPlainObject] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        feed <- map["posts"]
    }
    
}
