//
//  NewRequestCell.swift
//  Dream
//
//  Created by denis on 05.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

class NewRequestCell : UICollectionViewCell {
    
    static let identifier = "NewRequestCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "NewRequest"))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = loc("new_request.hint")
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.mediumFont(of: 20)
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
        
        containerView.addSubview(imageView.prepareForAutolayout())
        imageView.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .top, .bottom, andOffset: 15)
        imageView.height(equalTo: imageView.width, multiplier: 0.82)
        
        containerView.addSubview(label.prepareForAutolayout())
        label.centerX(to: imageView.centerX).centerY(to: imageView.centerY + 16)
    }
}
