//
//  NewRequestViewOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - NewRequestViewOutput

protocol NewRequestViewOutput {
    
    /// View is ready
    func didTriggerViewReadyEvent()
    
    func didTriggerCreatePost(name: String, age: Int, description: String, media: [UIImage])
    
    func didTriggerSetMediaBrand(withMediaImage image: UIImage)
}
