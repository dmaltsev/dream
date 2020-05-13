//
//  TableCellAction.swift
//

import UIKit

// MARK: - TableCellAction

struct TableCellAction {
    
    /// The cell that triggers an action
    let cell: UITableViewCell
    
    /// The action id
    let id: String
    
    /// Current notification center instance
    let notificationCenter: NotificationCenter = .default
    
    /// cell action
    func call() {
        notificationCenter.post(name: .customCellActionNotification, object: self)
    }
}
