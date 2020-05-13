//
//  ConfigurableCell.swift
//

import UIKit

// MARK: - ConfigurableCell

protocol ConfigurableCell {
    
    /// Data type
    associatedtype Element
    
    /// Cell's reuse identifier
    static var reuseIdentifier: String { get }

    /// Cell's estimated height
    static var estimatedHeight: CGFloat? { get }
    
    /// Cell's default height
    static var defaultHeight: CGFloat? { get }
    
    /// Setup data
    ///
    /// - Parameter _: some data for configuring
    func configure(with _: Element)
}

// MARK: - Default implementation

extension ConfigurableCell where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var estimatedHeight: CGFloat? {
        return nil
    }
    
    static var defaultHeight: CGFloat? {
        return nil
    }
}
