//
//  OnboardingModule.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - OnboardingModule

class OnboardingModule: Module {

    typealias Input = OnboardingModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return OnboardingModuleAssembly().obtainViewController()
    }
}