//
//  Hud.swift
//  Dream
//
//  Created by denis on 24/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

func hud(_ viewToAttach: UIView) {
    MBProgressHUD.showAdded(to: viewToAttach, animated: true)
}

func hud(_ viewToAttach: UIView, transform: Bool) {
//    WZLoadingHud.showHud(viewToAttach)
}

func hud(_ viewToAttach: UIView, title:String) {
    let hud = MBProgressHUD.showAdded(to: viewToAttach, animated: true)
    hud.label.text = title
}

func hudHide(_ viewToAttach: UIView) {
    MBProgressHUD.hide(for: viewToAttach, animated: true)
}

func hudHide(_ viewToAttach: UIView, animated: Bool) {
    MBProgressHUD.hide(for: viewToAttach, animated: animated)
}

func hudToast(_ viewToAttach: UIView, message: String, time:Double = 2) {
    let hud = MBProgressHUD.showAdded(to: viewToAttach, animated: true)
    hud.label.text = message
    let popTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    weak var hudWeak = hud
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        if let hud = hudWeak {
            hud.hide(animated: true)
        }
    }
}
