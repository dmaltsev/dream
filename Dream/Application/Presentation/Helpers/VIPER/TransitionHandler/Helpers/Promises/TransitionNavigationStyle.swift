//
//  TransitionNavigationStyle.swift
//  Мечта.ру
//

import Foundation

// MARK: - TransitionNavigationStyle

/// Style for your navigation between modules
///
/// - push: Push your module to UINavigationController
/// - pop: Pop your module in UINavigationController
/// - present: Present your module in UINavigationController
enum TransitionNavigationStyle {
    case push
    case pop
    case present
    case replaceLast
    case single
}
