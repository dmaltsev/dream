//
//  CollectableAssembly.swift
//  Мечта.ру
//

import Swinject

// MARK: - CollectableAssembly

protocol CollectableAssembly {

    init()

    /// Method for registering your assemblies
    ///
    /// - Parameter container: Container for dependency ijection
    func assemble(inContainer container: Container)
}

extension CollectableAssembly {

    /// Container with all dependencies
    var container: Container {
        return AssembliesHolder.container
    }

    /// Wrapper for protocol's assemble method
    func assemble() {
        self.assemble(inContainer: container)
    }
}
