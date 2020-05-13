//
//  MainRouterInput.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainRouterInput

protocol MainRouterInput: class {
    
    /// Close current module
    func close()
    
    func openNewRequest()
    
    func openPostDetails(_ post: PostPlainObject)
}
