//
//  UIButton.swift
//  Мечта.ру
//

import Foundation
import UIKit

extension UIButton {
    
    func setButtonEnabled(_ enabled: Bool, disabledAlpha: CGFloat = 0.5) {
        self.isUserInteractionEnabled = enabled
        self.alpha = enabled ? 1.0 : disabledAlpha
    }
    
}
