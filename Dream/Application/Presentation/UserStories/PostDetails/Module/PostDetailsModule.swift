//
//  PostDetailsModule.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - PostDetailsModule

class PostDetailsModule: Module {

    typealias Input = PostDetailsModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return PostDetailsModuleAssembly().obtainViewController()
    }
}