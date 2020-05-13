//
//  ApplicationSettingsRevealerImplementation.swift
//

import UIKit

// MARK: - ApplicationSettingsRevealerImplementation

class ApplicationSettingsRevealerImplementation {
    
    /// Current application instance
    fileprivate let application: UIApplication
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    /// - Parameter application: current application instance
    init(application: UIApplication) {
        self.application = application
    }
}

// MARK: - ApplicationSettingsRevealer

extension ApplicationSettingsRevealerImplementation: ApplicationSettingsRevealer {
    
    func openApplicationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        application.open(url, options: [:])
    }
    
}
