//
//  NewRequestInteractorInput.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - NewRequestInteractorInput

protocol NewRequestInteractorInput {
    
    func createPost(name: String, age: Int, description: String, media: [UIImage])
    
}
