//
//  TransitionHandler.swift
//  Мечта.ру
//

typealias TransitionSetupBlock<T> = (T) -> Void

// MARK: - TransitionHandler

protocol TransitionHandler: class {

    var moduleInput: ModuleInput? { get set }

    /// Transition with ModuleFactory
    ///
    /// - Parameters:
    ///   - moduleFactory: ModuleFactory instance
    ///   - type: ModuleInput type
    /// - Returns: Promise with setups
    func openModule<M>(_ moduleType: M.Type, controller: UIViewController?) -> TransitionPromise<M.Input> where M: Module

    /// Standard performSegueWithIdentifier
    ///
    /// - Parameter segueIdentifier: Given segue identifier
    func performSegue(_ segueIdentifier: String)

    /// Transition with segue identifier and setup block
    ///
    /// - Parameters:
    ///   - segueIdentifier: Given segue identifier
    ///   - type: Moduleinput type
    ///   - setup: Block for setup ModuleInput
    func openModuleUsingSegue<T>(_ segueIdentifier: String, to type: T.Type, setup: @escaping TransitionSetupBlock<T>)

    /// Close current module
    ///
    /// - Parameter animated: true if need to animate transition
    func closeCurrentModule(animated: Bool)

}

extension TransitionHandler {
    
    /// Transition with ModuleFactory
    ///
    /// - Parameters:
    ///   - moduleFactory: ModuleFactory instance
    ///   - type: ModuleInput type
    /// - Returns: Promise with setups
    func openModule<M>(_ moduleType: M.Type) -> TransitionPromise<M.Input> where M: Module {
        return openModule(M.self, controller: nil)
    }
}
