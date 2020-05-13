//
//  ApiConfig.swift
//  Dream
//
//  Created by denis on 07.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

struct ApiConfig {
    
    static let baseUrl = "http://84.201.137.141:8000"
    static let imagesUrl = "\(baseUrl)/static/"
    
}

struct Endpoint {
    static let getMedia = "/media"
    static let addMedia = "/media/?client_id=%@"
    static let getUser = "/user/%@"
    static let addUser = "/user?client_id=%@"
    static let updateUser = "/user"
    static let createPost = "/post?client_id=%@"
    static let getPost = "/post/%@"
    static let getPostComments = "/post/%@/comments?client_id=%@"
    static let createComment = "/comment?client_id=%@"
    static let getComment = "/comment/%@"
    static let createVote = "/vote/?client_id=%@"
    static let getFeed = "/feed"
}
