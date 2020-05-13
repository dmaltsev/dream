//
//  MainModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MainModuleInitializer

class MainModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var mainViewController: MainViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        MainModuleAssembly().configureModuleForViewInput(viewInput: mainViewController)
    }
}