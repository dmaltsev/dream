//
//  TableRowActionType.swift
//

import Foundation

// MARK: - TableRowActionType

enum TableRowActionType {

    case click
    case delete
    case move
    case select
    case deselect
    case willSelect
    case willDisplay
    case didEndDisplaying
    case shouldHighlight
    case accessory
    case height
    case canEdit
    case configure
    case canDelete
    case canMove
    case canMoveTo
    case custom(String)

    var key: String {
        switch (self) {
        case .custom(let key):
            return key
        default:
            return String(describing: self)
        }
    }
}
