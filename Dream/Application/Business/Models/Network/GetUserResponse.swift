//
//  GetUserResponse.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

class GetUserResponse : BaseNetworkResponse {
    
    var user: UserPlainObject?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        user = try? UserPlainObject(map: map)
    }
    
}

