//
//  TransitionStyle.swift
//  Мечта.ру
//

import Foundation

// MARK: - TransitionStyle

/// Sets the current transitional period
///
/// - navigationController: will be added to a navigation controller
/// - present: will be presented
enum TransitionStyle {
    case navigationController(navigationStyle: TransitionNavigationStyle)
    case present
}
