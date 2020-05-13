//
//  MenuModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuModuleInitializer

class MenuModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var menuViewController: MenuViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        MenuModuleAssembly().configureModuleForViewInput(viewInput: menuViewController)
    }
}