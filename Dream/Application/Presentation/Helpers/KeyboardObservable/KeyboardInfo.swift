//
//  KeyboardInfo.swift
//  Мечта.ру
//

import Foundation

// MARK: - KeyboardInfo

struct KeyboardInfo {
    
    // MARK: - Properties
    
    /// UIKeyboardFrameEndUserInfoKey value
    let frameEnd: CGRect
    
    /// UIKeyboardFrameBeginUserInfoKey value
    let frameBegin: CGRect
    
    /// UIKeyboardAnimationCurveUserInfoKey value
    let animationCurve: Int
    
    /// UIKeyboardAnimationDurationUserInfoKey value
    let animationDuration: Double
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameter userInfo: keyboard event data
    init(userInfo: [AnyHashable : Any]) {
        self.frameBegin = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        self.frameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        self.animationCurve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue ?? UIView.AnimationCurve.easeInOut.rawValue
        self.animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    }
}
