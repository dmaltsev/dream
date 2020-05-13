//
//  PostPlainObject.swift
//  Dream
//
//  Created by denis on 08.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

struct PostPlainObject : ImmutableMappable {
    
    let id: String
    let description: String
    let userId: String
    let created: Date?
    let commentCount: Int
    let mediaList: [MediaPlainObject]
    
    init(map: Map) throws {
        id = try map.value("post_id")
        description = try map.value("description")
        let userId: String = try map.value("user_id")
        commentCount = try map.value("comment_count")
        mediaList = try map.value("media_list")
        
        if let intUserId = Int(userId) {
            self.userId = "513b1a00-607e-451a-b486-427add5f3ee7"
        } else {
            self.userId = userId
        }
        
        let dateCreated: String = try map.value("date_created")
        created = DateFormatter.postDateFormatter().date(from: dateCreated)
    }
}
