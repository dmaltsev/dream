//
//  MenuCell.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuCell

class MenuCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFont(of: 14)
        return label
    }()
    
    // MARK: - UITableViewCell
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Useful
    
    private func setupLayout() {
        self.contentView.addSubview(iconView.prepareForAutolayout())
        iconView.centerY(to: contentView.centerY).left(to: contentView.left + 26)
        
        self.contentView.addSubview(titleView.prepareForAutolayout())
        titleView.centerY(to: contentView.centerY).left(to: iconView.right + 26)
    }
    
    func setup(with viewModel: MenuCellViewModelProtocol) {
        iconView.image = viewModel.icon
        titleView.text = viewModel.title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.contentView.backgroundColor = selected ? .white : .clear
    }
}
