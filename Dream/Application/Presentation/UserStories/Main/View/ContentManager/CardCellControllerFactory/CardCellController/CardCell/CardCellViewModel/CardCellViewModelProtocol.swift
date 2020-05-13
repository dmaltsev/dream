//
//  CardCellViewModelProtocol.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import Foundation

// MARK: - CardCellViewModelProtocol

protocol CardCellViewModelProtocol {
    var name: String { get }
    var age: Int { get }
    var request: String { get }
    
}
