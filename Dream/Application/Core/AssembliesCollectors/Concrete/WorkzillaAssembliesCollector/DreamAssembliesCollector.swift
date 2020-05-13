//
//  DreamAssembliesCollector.swift
//  Мечта.ру
//

import Swinject

// MARK: - DreamAssembliesCollector

class DreamAssembliesCollector: AssembliesCollector {

    required init() {

    }

    func collect(inContainer container: Container) {

        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        
        for index in 0..<typeCount where types[index] is CollectableAssembly.Type {
            if let assemblyType = (types[index] as? CollectableAssembly.Type) {
                let object = assemblyType.init()
                object.assemble(inContainer: container)
            }
        }

        types.deallocate()
    }
}
