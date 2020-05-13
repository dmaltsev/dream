//
//  Presenter.swift
//  Мечта.ру
//

import Foundation

// MARK: - SubmodulesHolder

protocol SubmodulesHolder {

    /// All available submodules in the current module
    var submodules: Submodules { get }
}

// MARK: - Presenter

class Submodules {

    /// All available sumbodules in the some module
    private var submodules: [(id: String?, submodule: ModuleInput)] = []
    
    /// Add new submodule
    ///
    /// - Parameters:
    ///   - submodule: some submodule
    ///   - identifier: submodule id (required if you use multiple submodules of the same type in the same storage)
    func add(_ submodule: ModuleInput, identifier: String? = nil) {
        submodules.append((id: identifier, submodule: submodule))
    }

    /// Obtain submodule by its type
    ///
    /// - Parameter type: submodule type
    /// - Returns: submodule if it's exists
    func obtain<T>(_ type: T.Type) -> T? {
        return submodules.first { $0.submodule is T }?.submodule as? T
    }

    /// Obtain submodule by its type and id
    ///
    /// - Parameters:
    ///   - type: submodule type
    ///   - id: submodule id
    /// - Returns: submodule if it's exists
    func obtain<T>(_ type: T.Type, byID id: String) -> T? {
        return submodules.first { $0.id == id }?.submodule as? T
    }
}
