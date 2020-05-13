//
//  UserServiceImplementation.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class UserServiceImplementation {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
}

extension UserServiceImplementation : UserService {
    
    func obtainUser(withUserId id: String) -> Observable<UserPlainObject?> {
        return Observable<UserPlainObject?>.create { [weak self] observer in
            
            if let user = self?.realm.object(ofType: UserPlainObject.self,
                                                forPrimaryKey: id) {
                observer.onNext(user)
                observer.onCompleted()
                return Disposables.create()
            }

            let request = ApiRouter.getUser(id: id)
            ApiClient.sharedInstance.performRequest(request: request,
                                                    responseHandler: { (response: GetUserResponse) -> (Void) in
                                                        if let user = response.user {
                                                            try? self?.realm.write {
                                                                self?.realm.add(user, update: .all)
                                                            }
                                                        }
                                                        observer.onNext(response.user)
                                                        observer.onCompleted()
            }) { error -> (Void) in
//                observer.onError(error)
            }

            return Disposables.create()
        }
    }
    
    func createUser(name: String, age: Int, avatar: String?) -> Observable<UserPlainObject?> {
          return Observable<UserPlainObject?>.create { observer in
            let request = ApiRouter.createUser(name: name, age: age, avatar: avatar)
            ApiClient.sharedInstance.performRequest(request: request,
                                                    responseHandler: { (response: GetUserResponse) -> (Void) in
                                                        observer.onNext(response.user)
                                                        observer.onCompleted()
            }) { error -> (Void) in
//                observer.onError(error)
            }

            return Disposables.create()
        }
    }
    
}
