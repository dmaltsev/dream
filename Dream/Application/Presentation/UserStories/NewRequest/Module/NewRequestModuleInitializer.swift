//
//  NewRequestModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - NewRequestModuleInitializer

class NewRequestModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var newrequestViewController: NewRequestViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        NewRequestModuleAssembly().configureModuleForViewInput(viewInput: newrequestViewController)
    }
}