//
//  PostDetailsModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - PostDetailsModuleInitializer

class PostDetailsModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var postdetailsViewController: PostDetailsViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        PostDetailsModuleAssembly().configureModuleForViewInput(viewInput: postdetailsViewController)
    }
}