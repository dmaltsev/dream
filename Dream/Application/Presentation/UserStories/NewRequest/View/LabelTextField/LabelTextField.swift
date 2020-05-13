//
//  LabelTextField.swift
//  Dream
//
//  Created by denis on 07.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import UIKit

class LabelTextField : UIView {
    
    var text: String {
        return textField.text ?? ""
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFont(of: 16)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.mediumFont(of: 16)
        return textField
    }()
    
    private let textFieldUnderline: UIView = {
        let view = UIView()
        view.backgroundColor = .underlineGray
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.label.text = title
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(label.prepareForAutolayout())
        label.pinToSuperview(withSides: .left).centerY(to: self.centerY)
        
        self.addSubview(textField.prepareForAutolayout())
        textField.pinToSuperview(withSides: .right)
            .centerY(to: label.centerY)
            .left(to: label.right + 12)
            .height.equal(to: 36)
        
        self.addSubview(textFieldUnderline.prepareForAutolayout())
        textFieldUnderline.left(to: textField.left).right(to: textField.right)
            .top(to: textField.bottom)
            .height.equal(to: 1)
    }
    
}
