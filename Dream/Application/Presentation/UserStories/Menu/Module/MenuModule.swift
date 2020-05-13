//
//  MenuModule.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuModule

class MenuModule: Module {

    typealias Input = MenuModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return MenuModuleAssembly().obtainViewController()
    }
}