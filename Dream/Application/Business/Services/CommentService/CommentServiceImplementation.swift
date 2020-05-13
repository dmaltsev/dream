//
//  CommentServiceImplementation.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class CommentServiceImplementation {
    
}

extension CommentServiceImplementation : CommentService {
    
    func postComment(forPostWithId id: String, comment: String) -> Observable<CommentPlainObject?> {
        return Observable<CommentPlainObject?>.create { observer in
            let request = ApiRouter.createComment(postId: id, comment: comment)
            ApiClient.sharedInstance.performRequest(request: request, responseHandler: { (response: CreateCommentResponse) -> (Void) in
                observer.onNext(response.comment)
                observer.onCompleted()
            }, errorHandler: { error -> (Void) in
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
    func obtainComments(forPostWithId id: String) -> Observable<[CommentPlainObject]> {
        return Observable<[CommentPlainObject]>.create { [weak self] observer in
            
            let request = ApiRouter.getPostComments(id: id)
            ApiClient.sharedInstance.performRequest(request: request) { response -> (Void) in
                if let response = response, let comments = Mapper<CommentPlainObject>().mapArray(JSONString: response) {
                    observer.onNext(comments)
                } else {
                    observer.onNext([])
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
