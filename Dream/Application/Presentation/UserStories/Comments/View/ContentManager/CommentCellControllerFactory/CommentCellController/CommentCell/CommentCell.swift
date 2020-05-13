//
//  CommentCell.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentCell

class CommentCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - UITableViewCell
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Useful
    
    func setup(with viewModel: CommentCellViewModelProtocol) {
        self.textLabel?.text = viewModel.comment.body
    }
}
