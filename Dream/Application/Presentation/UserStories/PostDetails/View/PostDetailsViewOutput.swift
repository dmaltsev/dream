//
//  PostDetailsViewOutput.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation

// MARK: - PostDetailsViewOutput

protocol PostDetailsViewOutput {
    
    /// View is ready
    func didTriggerViewReadyEvent()
    
    func didTriggeredObtainUser(_ id: String)
    
    func didTriggeredObtainComments()
    
    func didTriggeredPostComment(_ comment: String)
    
    func didTriggeredVote(forMediaWithId mediaId: String)
}
