//
//  MainViewOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - MainViewOutput

protocol MainViewOutput {
    
    /// View is ready
    func didTriggerViewReadyEvent()
    
    func didTriggerOpenNewRequest()
    
    func didTriggerObtainFeed()
    
    func didTriggerOpenPostDetails(_ post: PostPlainObject)
}
