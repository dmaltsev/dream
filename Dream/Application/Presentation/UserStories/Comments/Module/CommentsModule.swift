//
//  CommentsModule.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentsModule

class CommentsModule: Module {

    typealias Input = CommentsModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return CommentsModuleAssembly().obtainViewController()
    }
}