//
//  Module.swift
//  Мечта.ру
//

import UIKit

// MARK: - Module

protocol Module {

    /// ModuleInput type
    associatedtype Input

    /// Instantiate transition handler
    ///
    /// - Returns: UIViewController instance
    static func instantiateTransitionHandler() -> UIViewController
}
