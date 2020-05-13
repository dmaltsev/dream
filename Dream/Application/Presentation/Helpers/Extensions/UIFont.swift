//
//  UIFont.swift
//  Мечта.ру
//

import UIKit

// MARK: - UIFont

extension UIFont {
    
    static func mediumFont(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
    
    static func regularFont(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
}
