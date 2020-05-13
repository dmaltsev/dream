//
//  PostDetailsModuleInput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - PostDetailsModuleInput

protocol PostDetailsModuleInput: ModuleInput {
    
    func setPost(_ post: PostPlainObject?)
    
}
