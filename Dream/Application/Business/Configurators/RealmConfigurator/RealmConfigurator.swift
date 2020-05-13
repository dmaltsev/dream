//
//  RealmConfigurator.swift
//  Dream
//
//  Created by denis on 31.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RealmSwift

class RealmConfigurator {
    
    init() {
        
    }
    
}

extension RealmConfigurator : Configurator {
    
    func configure() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        Realm.Configuration.defaultConfiguration = config
        do {
            try _ = Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
