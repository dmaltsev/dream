//
//  CellHeightCalculator.swift
//  Daisy
//

import UIKit

// MARK: - CellHeightCalculator

protocol CellHeightCalculator {
    
    /// Calculate row's cell height
    ///
    /// - Parameters:
    ///   - row: some table row
    ///   - indexPath: row's indexPath
    /// - Returns: row's cell heigh
    func height(forRow row: TableRow, at indexPath: IndexPath) -> CGFloat

    /// Calculate estimated row's cell height
    ///
    /// - Parameters:
    ///   - row: some table row
    ///   - indexPath: row's indexPath
    /// - Returns: estimated row's cell height
    func estimatedHeight(forRow row: TableRow, at indexPath: IndexPath) -> CGFloat
    
    /// Reset calculator state
    func invalidate()
}
