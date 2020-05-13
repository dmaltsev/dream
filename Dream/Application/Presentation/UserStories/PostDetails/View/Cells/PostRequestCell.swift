//
//  PostRequestCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

class PostRequestCell : UICollectionViewCell {
    
    static let identifier = "PostRequestCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        label.font = UIFont.regularFont(of: 13)
        return label
    }()
 
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(containerView.prepareForAutolayout())
        containerView.pinToSuperview()
        
        containerView.addSubview(titleLabel.prepareForAutolayout())
        titleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .top)
    }
    
    func setup(withModel model: PostRequestCellModel) {
        titleLabel.text = model.post.description
    }
}

