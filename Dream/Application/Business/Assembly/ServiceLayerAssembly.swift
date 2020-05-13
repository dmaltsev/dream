//
//  ServiceLayerAssembly.swift
//  Dream
//
//  Created by denis on 09.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Swinject
import RealmSwift

// MARK: - ServiceLayerAssembly

class ServiceLayerAssembly: CollectableAssembly {

    required init() {

    }

    func assemble(inContainer container: Container) {
        
        container.register(MediaService.self) { resolver in
            return MediaServiceImplementation()
        }
        
        container.register(UserService.self) { resolver in
            return UserServiceImplementation()
        }
        
        container.register(FeedService.self) { resolver in
            return FeedServiceImplementation()
        }
        
        container.register(PostService.self) { resolver in
            return PostServiceImplementation()
        }
        
        container.register(CommentService.self) { resolver in
            return CommentServiceImplementation()
        }
    }
    
}

