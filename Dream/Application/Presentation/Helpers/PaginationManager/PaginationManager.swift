//
//  PaginationManager.swift
//  Мечта.ру
//

import Foundation

// MARK: - PaginationManager

protocol PaginationManager {
    
    /// true if loading is in process
    var isLoading: Bool { get }
    
    /// Configure some scrollView to observing
    ///
    /// - Parameter scrollView: current scrollView instance
    func configure(with scrollView: UIScrollView)
    
    /// Set finished state
    ///
    /// - Parameter finish: true if loading was finished
    func endLoading(finish: Bool)
}
