//
//  ViewOutputProvider.swift
//  Мечта.ру
//

import Foundation

// MARK: - ViewOutputProvider

protocol ViewOutputProvider {

    /// Module input for the current object
    var viewOutput: ModuleInput? { get }
}
