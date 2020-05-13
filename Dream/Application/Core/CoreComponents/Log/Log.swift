//
//  Log.swift
//  Dream
//
//  Created by denis on 24/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Foundation

/// Shared log instance
let log = Log()

// MARK: - Log

class Log {
    
    // MARK: - Properties
    
    private let logEnabled = true
    
    // MARK: - Initializers
    
    init() {
        
    }

    /// Log debug message
    ///
    /// - Parameter message: debug message
    func debug(_ message: String) {
        guard logEnabled else {
            return
        }
        print("[DEBUG]: \(message)")
    }
    
    /// Log error message
    ///
    /// - Parameter message: error message
    func error(_ message: String) {
        guard logEnabled else {
            return
        }
        print("[ERROR]: \(message)")
    }
    
    /// Log info message
    ///
    /// - Parameter message: info message
    func info(_ message: String) {
        guard logEnabled else {
            return
        }
        print("[INFO]: \(message)")
    }
    
    /// Log warning message
    ///
    /// - Parameter message: warning message
    func warning(_ message: String) {
        guard logEnabled else {
            return
        }
        print("[WARNING]: \(message)")
    }
}
