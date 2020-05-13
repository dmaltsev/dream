//
//  CommentService.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

protocol CommentService {
    
    func postComment(forPostWithId id: String, comment: String) -> Observable<CommentPlainObject?>
    
    func obtainComments(forPostWithId id: String) -> Observable<[CommentPlainObject]>
    
}
