//
//  UIViewController+Swizzling.swift
//  Мечта.ру
//

import Foundation
import UIKit

extension UIViewController {
    
    @objc func swizzledPresent(_ controller: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        if controller is UIAlertController {
            self.swizzledPresent(controller, animated: animated, completion: {
                controller.view.superview?.isUserInteractionEnabled = true
                controller.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: #selector(UIAlertController.hide)))
            })
        } else {
            self.swizzledPresent(controller, animated: animated, completion: completion)
        }
    }
}
