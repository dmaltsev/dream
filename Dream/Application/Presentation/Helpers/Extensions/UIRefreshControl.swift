//
//  UIRefreshControl.swift
//  Мечта.ру
//

import UIKit

// MARK: - UIRefreshControl

extension UIRefreshControl {

    func setTopOffset(_ offset: CGFloat) {
        bounds = CGRect(x: bounds.origin.x, y: -1 * offset, width: bounds.size.width, height: bounds.size.height)
    }
}
