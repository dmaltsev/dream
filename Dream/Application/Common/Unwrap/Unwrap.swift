//
//  Unwrap.swift
//  Мечта.ру
//

import Foundation

/// Returns object as unoptional if it isn't nil
///
/// - Parameter object: checkable object
/// - Returns: result as unoptional

func unwrap<T>(_ object: T?) -> T {
    
    guard let result = object else {
        fatalError("Cannot unwrap \(T.self). Object = nil")
    }
    
    return result
}
