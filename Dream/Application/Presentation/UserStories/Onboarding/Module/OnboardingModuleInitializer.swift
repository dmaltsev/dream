//
//  OnboardingModuleInitializer.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - OnboardingModuleInitializer

class OnboardingModuleInitializer: NSObject {

    // MARK: - Properties
    
    //Connect with object on storyboard
    @IBOutlet weak var onboardingViewController: OnboardingViewController!

    // MARK: - NSObject

    override func awakeFromNib() {
        OnboardingModuleAssembly().configureModuleForViewInput(viewInput: onboardingViewController)
    }
}