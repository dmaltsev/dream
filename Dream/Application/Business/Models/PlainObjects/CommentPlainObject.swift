//
//  CommentPlainObject.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

struct CommentPlainObject : ImmutableMappable {
    
    let postId: String
    let body: String
    let userId: String
    let commentId: String
    
    init(map: Map) throws {
        postId = try map.value("post_id")
        body = try map.value("body")
        userId = try map.value("user_id")
        commentId = try map.value("comment_id")
    }
}
