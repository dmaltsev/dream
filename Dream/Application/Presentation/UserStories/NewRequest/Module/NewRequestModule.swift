//
//  NewRequestModule.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - NewRequestModule

class NewRequestModule: Module {

    typealias Input = NewRequestModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return NewRequestModuleAssembly().obtainViewController()
    }
}