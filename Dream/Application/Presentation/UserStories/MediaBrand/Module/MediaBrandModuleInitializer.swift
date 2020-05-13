//
//  MediaBrandModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MediaBrandModuleInitializer

class MediaBrandModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var mediabrandViewController: MediaBrandViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        MediaBrandModuleAssembly().configureModuleForViewInput(viewInput: mediabrandViewController)
    }
}