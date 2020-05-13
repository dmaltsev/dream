//
//  MainInteractorOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: class, InteractorOutput {
    
    func obtainFeedSuccess(_ feed: [PostPlainObject])
    
}
