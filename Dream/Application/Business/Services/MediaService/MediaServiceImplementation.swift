//
//  MediaServiceImplementation.swift
//  Dream
//
//  Created by denis on 14.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class MediaServiceImplementation {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
}

extension MediaServiceImplementation : MediaService {
    
    func obtainMediaDetails(forMediaId id: String) -> Observable<MediaDetailsPlainObject?> {
        return Observable<MediaDetailsPlainObject?>.create { [weak self] observer in
            
            if let details = self?.realm.object(ofType: MediaDetailsPlainObject.self,
                                                forPrimaryKey: id) {
                observer.onNext(details)
                observer.onCompleted()
                return Disposables.create()
            }
            
            let request = ApiRouter.getMedia(mediaId: id)
            ApiClient.sharedInstance.performRequest(request: request,
                                                    responseHandler: { [weak self] (response: GetMediaDetailsResponse) -> (Void) in
                                                        if let details = response.mediaDetails {
                                                            try? self?.realm.write {
                                                                self?.realm.add(details, update: .all)
                                                            }
                                                        }
                                                        observer.onNext(response.mediaDetails)
                                                        observer.onCompleted()
            }) { error -> (Void) in
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func sendMedia(withData data: Data, andBrand brand: String) -> Observable<MediaDetailsPlainObject?> {
        return Observable<MediaDetailsPlainObject?>.create { observer in
            let request = ApiRouter.addMedia
            let params:[String: Any] = [ "media": data ]
            ApiClient.sharedInstance.performMultipartRequest(request: request, params: params, responseHandler: { (response: GetMediaDetailsResponse) -> (Void) in
                observer.onNext(response.mediaDetails)
                observer.onCompleted()
            }) { error -> (Void) in
                
            }
            return Disposables.create()
        }
    }
}
