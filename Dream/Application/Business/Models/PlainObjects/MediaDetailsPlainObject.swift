//
//  MediaDetailsPlainObject.swift
//  Dream
//
//  Created by denis on 14.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class MediaDetailsPlainObject : Object, ImmutableMappable  {
    
    @objc dynamic var id: String = ""
    @objc dynamic var clientId: String = ""
    @objc dynamic var url: String? = nil
    @objc dynamic var thumbnailUrl: String? = nil
    
    required convenience init(map: Map) throws {
        self.init()
        id = try map.value("media_id")
        clientId = try map.value("client_id")
        thumbnailUrl = try? map.value("thumbnail_url")
        url = try? map.value("url")
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
