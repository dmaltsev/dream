//
//  InteractorOutput.swift
//  Мечта.ру
//

import Foundation

// MARK: - InteractorOutput

protocol InteractorOutput {

    /// Method for presenters which receives Interactor's errors
    ///
    /// - Parameter errorMessage: Error message
    func processErrorMessage(_ errorMessage: String)
}
