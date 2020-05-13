//
//  ModuleInput.swift
//  Мечта.ру
//

import Foundation

// MARK: - ModuleInput

protocol ModuleInput {

    /// Set module output for the current module
    ///
    /// - Parameter moduleOutput: ModuleOutput instance
    func setModuleOutput(_ moduleOutput: ModuleOutput)
}

extension ModuleInput {

    func safe<T>(call: @escaping (T) -> ()) {
        if let instance = self as? T {
            call(instance)
        }
    }

    func setModuleOutput(_ moduleOutput: ModuleOutput) {

    }
}
