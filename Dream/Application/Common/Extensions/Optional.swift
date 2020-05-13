//
//  Optional.swift
//  Dream
//
//  Created by denis on 24/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Foundation

// MARK: - Optional

extension Optional {
    
    public func unwrap(_ hint: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        guard let unwrapped = self else {
            var message = "Required value was nil in \(file), at line \(line)"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
    
    func unwrap<T>(as type: T.Type, withHint hint: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
        guard let unwrapped = self as? T else {
            var message = "Required value cannot be converted to '\(T.self)' in \(file), at line \(line)"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
}

protocol Convertible {

}

extension Convertible {

    func `as`<T>(_ type: T.Type, withHint hint: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
        guard let unwrapped = self as? T else {
            var message = "Required value cannot be converted to '\(T.self)' in \(file), at line \(line)"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
}

