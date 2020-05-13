//
//  DateFormatter.swift
//  Dream
//
//  Created by denis on 08.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func postDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter(withFormat: "yyyy-MM-ddTHH:mm:ss.SSSSSS", locale: "ru_RU")
        return dateFormatter
    }
    
}
