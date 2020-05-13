//
//  UserPlainObject.swift
//  Dream
//
//  Created by denis on 14.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class UserPlainObject : Object, ImmutableMappable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String? = nil
    @objc dynamic var age: Int = 0
    
    required convenience init(map: Map) throws {
        self.init()
        id = try map.value("user_id")
        name = try map.value("name")
        avatar = try? map.value("avatar")
        age = try map.value("age")
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
