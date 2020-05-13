//
//  UserService.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

protocol UserService {
    
    func obtainUser(withUserId id: String) -> Observable<UserPlainObject?>
    
    func createUser(name: String, age: Int, avatar: String?) -> Observable<UserPlainObject?>
    
}
