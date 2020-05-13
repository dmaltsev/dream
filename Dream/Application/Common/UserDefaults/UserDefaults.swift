//
//  UserDefaults.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setOnboardingShowed(_ showed: Bool) {
        self.set(showed, forKey: "OnboardingShowed")
    }
    
    func isOnboardingShowed() -> Bool {
        return self.bool(forKey: "OnboardingShowed")
    }
    
}
