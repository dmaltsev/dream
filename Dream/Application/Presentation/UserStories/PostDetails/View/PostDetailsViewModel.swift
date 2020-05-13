//
//  PostDetailsViewModel.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation


/// MARK - Protocols

protocol PostDetailsViewModelProtocol {
    var id: Int { get }
}

protocol PostCommentViewModelProtocol : PostDetailsViewModelProtocol {
    var comment: CommentPlainObject { get }
}

protocol PostMediaViewModelProtoc : PostDetailsViewModelProtocol {
    var media: MediaPlainObject { get }
    var post: PostPlainObject { get }
}

/// MARK - Implementations

struct PostMediaViewModel : PostDetailsViewModelProtocol {
    let id: Int
    let media: MediaPlainObject
    let post: PostPlainObject
}

struct PostCommentViewModel : PostCommentViewModelProtocol {
    let id: Int
    let comment: CommentPlainObject
}
