//
//  GetMediaDetailsResponse.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMediaDetailsResponse : BaseNetworkResponse {
    
    var mediaDetails: MediaDetailsPlainObject?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        mediaDetails = try? MediaDetailsPlainObject(map: map)
    }
    
}

