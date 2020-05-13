//
//  CommentsModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentsModuleInitializer

class CommentsModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var commentsViewController: CommentsViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        CommentsModuleAssembly().configureModuleForViewInput(viewInput: commentsViewController)
    }
}