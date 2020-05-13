//
//  CreateCommentResponse.swift
//  Dream
//
//  Created by denis on 02.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateCommentResponse : BaseNetworkResponse {
    
    var comment: CommentPlainObject?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        comment = try? CommentPlainObject(map: map)
    }
    
}

