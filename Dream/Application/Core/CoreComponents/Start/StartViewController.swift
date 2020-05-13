//
//  StartViewController.swift
//  Dream
//
//  Created by denis on 05.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import UIKit

class StartViewController : UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backIndicatorImage = UIImage(named: "Back")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back")
        self.navigationBar.tintColor = .redNavBar
        
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if viewController is OnboardingViewController {
            self.setNavigationBarHidden(true, animated: false)
        } else {
            self.setNavigationBarHidden(false, animated: false)
        }
    }
    
}
