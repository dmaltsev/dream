//
//  MainModule.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MainModule

class MainModule: Module {

    typealias Input = MainModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return MainModuleAssembly().obtainViewController()
    }
}