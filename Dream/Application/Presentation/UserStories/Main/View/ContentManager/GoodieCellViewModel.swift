//
//  GoodieCellViewModel.swift
//  Dream
//
//  Created by denis on 26/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import Foundation

// MARK: - GoodieCellViewModelProtocol

protocol GoodieGeneralViewModelProtocol {
    var id: Int { get }
}

protocol GoodieCellViewModelProtocol : GoodieGeneralViewModelProtocol {
    var media: MediaPlainObject { get }
    var post: PostPlainObject { get }
}

protocol GoodieHeaderCellViewModelProtocol : GoodieGeneralViewModelProtocol {
    var post: PostPlainObject { get }
}

struct GoodieCellViewModel : GoodieCellViewModelProtocol {
    let id: Int
    let media: MediaPlainObject
    let post: PostPlainObject
}

struct GoodieHeaderCellViewModel : GoodieHeaderCellViewModelProtocol {
    let id: Int
    let post: PostPlainObject
}

