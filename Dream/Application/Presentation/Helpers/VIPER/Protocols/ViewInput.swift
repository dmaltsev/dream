//
//  ViewInput.swift
//  Мечта.ру
//

protocol ViewInput {

    /// Waiting state
    func startIndication()

    /// Stop 'Waiting state'
    func stopIndication()

    /// Show success state
    func showSuccess()

    /// Show some message
    ///
    /// - Parameter message: Message text
    func showMessage(_ message: String)

    /// Show some error message
    ///
    /// - Parameters:
    ///   - message: error message text
    ///   - disappearingAfter: disappearing interval
    func showErrorMessage(_ message: String, disappearingAfter: TimeInterval)

    /// Show some error message
    ///
    /// - Parameter errorMessage: Error message text
    func showErrorMessage(_ errorMessage: String)

    /// Show unknown error message
    func showError()

    /// Show some error message
    ///
    /// - Parameter errorMessage: Error message text
    func showStandaloneErrorMessage(_ errorMessage: String)
}

extension ViewInput {

    func showStandaloneErrorMessage(_ errorMessage: String) {
        if let vc = UIApplication.shared.windows.first?.rootViewController {
            hudToast(vc.view, message: errorMessage)
        }
    }
}

// MARK: - UIViewController

extension ViewInput where Self: UIViewController {

    func startIndication() {
        hud(view)
    }

    func stopIndication() {
        hudHide(view)
    }

    func showSuccess() {
        hudHide(view)
    }

    func showMessage(_ message: String) {
        hudToast(view, message: message)
    }

    func showErrorMessage(_ message: String, disappearingAfter: TimeInterval) {
        hudToast(view, message: message, time: disappearingAfter)
    }

    func showErrorMessage(_ errorMessage: String) {
        hudToast(view, message: errorMessage)
    }

    func showError() {
        hudToast(view, message: "Упс! Произошла ошибка.")
    }
}

// MARK: - UIView

extension ViewInput where Self: UIView {

    var parentViewController: UIViewController? {
        return nil
    }

    func startIndication() {
        let view = parentViewController?.view ?? self
        hud(view)
    }

    func stopIndication() {
        let view = parentViewController?.view ?? self
        hudHide(view)
    }
    
    func showSuccess() {
        let view = parentViewController?.view ?? self
        hudHide(view)
    }
    
    func showMessage(_ message: String) {
        let view = parentViewController?.view ?? self
        hudToast(view, message: message)
    }

    func showErrorMessage(_ message: String, disappearingAfter: TimeInterval) {
        let view = parentViewController?.view ?? self
        hudToast(view, message: message, time: disappearingAfter)
    }

    func showErrorMessage(_ errorMessage: String) {
        let view = parentViewController?.view ?? self
        hudToast(view, message: errorMessage)
    }
    
    func showError() {
        let view = parentViewController?.view ?? self
        hudToast(view, message: "Упс! Произошла ошибка.")
    }
}
