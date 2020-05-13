//
//  PostService.swift
//  Dream
//
//  Created by denis on 16.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

protocol PostService {
    
    func addPost(description: String, mediaIds:[String]) -> Observable<PostPlainObject?>
    
    func vote(forPostWithId id: String, forMediaWithId mediaId: String) -> Observable<Void>
    
}
