//
//  ConfiguratorAssembly.swift
//  Dream
//
//  Created by denis on 31.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import Swinject

class ConfiguratorAssembly: CollectableAssembly {
    
    required init() {
        
    }
    
    func assemble(inContainer container: Container) {
        
        container.register(RealmConfigurator.self) { resolver in
            return RealmConfigurator()
        }
        
        container.register([Configurator].self) { resolver in
            let configurators: [Configurator] = [
                resolver.resolve(RealmConfigurator.self).unwrap()
            ]
            return configurators
        }
    }
}
