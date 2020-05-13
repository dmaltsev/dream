//
//  CreatePostResponse.swift
//  Dream
//
//  Created by denis on 16.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

class CreatePostResponse : BaseNetworkResponse {
    
    var post: PostPlainObject?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        post = try? PostPlainObject(map: map)
    }
    
}

