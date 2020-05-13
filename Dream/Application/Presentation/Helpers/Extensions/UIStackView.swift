//
//  UIStackView.swift
//  Мечта.ру
//

import Foundation
import UIKit

// MARK: - UIStackView

extension UIStackView {

    func arrangedSubviews<T: UIView>(_ type: T.Type) -> [T] {
        return arrangedSubviews.compactMap { $0 as? T }
    }

    func removeAllArrangedSubviews() {

        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })

        // Remove the views from self
        removedSubviews.forEach { $0.removeFromSuperview() }
    }
}
