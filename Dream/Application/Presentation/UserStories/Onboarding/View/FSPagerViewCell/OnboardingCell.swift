//
//  OnboardingCell.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import FSPagerView

class OnboardingCell : FSPagerViewCell {
    
    let actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "WhiteButton"), for: .normal)
        button.isHidden = true
        button.setTitleColor(.buttonRedLabel, for: .normal)
        return button
    }()
    
    static let reuseIdentifier = "OnboardingCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupActionButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.bringSubviewToFront(actionButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupActionButton() {
        self.contentView.addSubview(actionButton.prepareForAutolayout())
        actionButton.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .bottom, andOffset: 64)
            .height.equal(to: 56)
    }
    
}
