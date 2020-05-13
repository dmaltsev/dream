//
//  InfrastructureAssembly.swift
//  Dream
//
//  Created by denis on 24/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Swinject

// MARK: - DreamInfrastructureAssembly

class DreamInfrastructureAssembly: CollectableAssembly {
    
    required init() {
        
    }
    
    func assemble(inContainer container: Container) {
        
        container.register(Container.self) { resolver in
            return AssembliesHolder.container
        }
        
        container.register(FileManager.self) { resolver in
            return .default
        }
        
        container.register(UIApplication.self) { resolver in
            return UIApplication.shared
        }
        
        container.register(NotificationCenter.self) { resolver in
            return NotificationCenter.default
        }
        
        container.register(Bundle.self) { resolver in
            return Bundle.main
        }

        container.register(UNUserNotificationCenter.self) { resolver in
            return UNUserNotificationCenter.current()
        }
    }
}

