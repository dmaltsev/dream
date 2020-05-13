//
//  MediaPlainObject.swift
//  Dream
//
//  Created by denis on 08.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

struct MediaPlainObject : ImmutableMappable {
    
    let id: String
    let voteCount: Int
    
    init(map: Map) throws {
        id = try map.value("media_id")
        voteCount = try map.value("vote_count")
    }
}
