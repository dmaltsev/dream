//
//  LocalizeFunctions.swift
//  Dream
//
//  Created by denis on 05.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation


func loc(_ string: String) -> String {
    let result = NSLocalizedString(string, comment: "")
    return result == string ? "" : result
}
