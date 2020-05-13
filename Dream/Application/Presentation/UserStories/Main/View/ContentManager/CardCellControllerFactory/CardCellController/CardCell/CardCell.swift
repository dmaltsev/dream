//
//  CardCell.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CardCell

class CardCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
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
    
    func setup(with viewModel: CardCellViewModelProtocol) {
        
    }
}
