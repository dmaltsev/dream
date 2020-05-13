//
//  ApiRouter.swift
//  Dream
//
//  Created by denis on 07.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter : URLRequestConvertible {
    
    case getMedia(mediaId: String)
    case addMedia
    case getUser(id: String)
    case createUser(name: String, age: Int, avatar: String?)
    case updateUser(name: String, age: Int, avatar: String?)
    case createPost(description: String, mediaIds: [String])
    case getPost(id: String)
    case getPostComments(id: String)
    case createComment(postId: String, comment: String)
    case getComment(id: String)
    case createVote(postId: String, mediaId: String)
    case getFeed
    
    var method: HTTPMethod {
        switch self {
        case .getMedia, .getUser, .getPost, .getPostComments, .getComment, .getFeed:
            return .get
        case .addMedia, .createUser, .createPost, .createComment, .createVote:
            return .post
        case .updateUser:
            return .patch
        default:
            return .get
        }
    }
    
    var params: Parameters {
        switch self {
        case .getUser:
            return ["client_id": "513b1a00-607e-451a-b486-427add5f3ee7"]
        case .getMedia(let mediaId):
            return ["media_id": mediaId, "client_id": "513b1a00-607e-451a-b486-427add5f3ee7"]
        case .createUser(let name, let age, let avatar):
            var params: [String: Any] = [ "name": name, "age": age ]
            if let avatar = avatar {
                params["avatar"] = avatar
            }
            return params
        case .createPost(let description, let mediaIds):
            return ["description": description, "media_ids": mediaIds]
        case .createComment(let postId, let comment):
            return ["post_id": postId, "body": comment]
        case .createVote(let postId, let mediaId):
            return ["post_id": postId, "media_id": mediaId]
        default:
            return [:]
        }
    }
    
    var baseUrl:String {
        return ApiConfig.baseUrl
    }
    
    var endpoint:String {
        switch self {
        case .getMedia:
            return Endpoint.getMedia
        case .addMedia:
            return String(format: Endpoint.addMedia, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .getUser(let id):
            return String(format: Endpoint.getUser, id)
        case .createUser:
            return String(format: Endpoint.addUser, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .updateUser:
            return Endpoint.updateUser
        case .createPost:
            return String(format: Endpoint.createPost, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .getPost(let id):
            return String(format: Endpoint.getPost, id)
        case .getPostComments(let id):
            return String(format: Endpoint.getPostComments, id, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .createComment:
            return String(format: Endpoint.createComment, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .getComment(let id):
            return String(format: Endpoint.getComment, id)
        case .createVote:
            return String(format: Endpoint.createVote, "513b1a00-607e-451a-b486-427add5f3ee7")
        case .getFeed:
            return Endpoint.getFeed
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMedia, .getUser, .getPost, .getPostComments, .getComment, .getFeed:
            return URLEncoding()
        case .addMedia:
            return URLEncoding()
        case .createUser, .createPost, .createComment, .createVote:
            return JSONEncoding()
        case .updateUser:
            return JSONEncoding()
        default:
            return JSONEncoding()
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        let serverUrl = "\(self.baseUrl)\(self.endpoint)"
        let url = URL(string: serverUrl)!
        var urlRequest = URLRequest(url: url)
        
        var params = self.params
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: params)
    }
}
