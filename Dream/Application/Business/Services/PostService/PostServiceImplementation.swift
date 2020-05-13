//
//  PostServiceImplementation.swift
//  Dream
//
//  Created by denis on 16.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

class PostServiceImplementation {
    
}

extension PostServiceImplementation : PostService {
    
    func addPost(description: String, mediaIds: [String]) -> Observable<PostPlainObject?> {
        return Observable<PostPlainObject?>.create { observer in
            let request = ApiRouter.createPost(description: description, mediaIds: mediaIds)
            ApiClient.sharedInstance.performRequest(request: request,
                                                    responseHandler: { (response: CreatePostResponse) -> (Void) in
                                                        observer.onNext(response.post)
                                                        observer.onCompleted()
            }) { error -> (Void) in
        //                observer.onError(error)
            }

            return Disposables.create()
        }
    }
    
    func vote(forPostWithId id: String, forMediaWithId mediaId: String) -> Observable<Void> {
        return Observable<Void>.create { observer in
            let request = ApiRouter.createVote(postId: id, mediaId: mediaId)
            ApiClient.sharedInstance.performRequest(request: request,
                                                    responseHandler: { (response: BaseNetworkResponse) -> (Void) in
                                                        observer.onNext(())
                                                        observer.onCompleted()
            }) { error -> (Void) in
                //                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
}

