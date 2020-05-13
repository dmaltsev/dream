//
//  PostComposeCommentCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

class PostComposeCommentCell : UICollectionViewCell {
    
    static let identifier = "PostComposeCommentCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 18
        textField.layer.masksToBounds = true
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.textFieldStoke.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = loc("new_comment.hint")
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 36))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 36))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
    
        return textField
    }()
    
    private lazy var composeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "CommentCompose"), for: .normal)
        button.addTarget(self, action: #selector(didTapComposeComment), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .commentsBackgroundColor
        self.contentView.backgroundColor = .commentsBackgroundColor
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .commentsBackgroundColor
        self.contentView.backgroundColor = .commentsBackgroundColor
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(containerView.prepareForAutolayout())
        containerView.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .top, .bottom)
        
        containerView.addSubview(composeButton.prepareForAutolayout())
        composeButton.width.equal(to: 36)
        composeButton.height.equal(to: 36)
        composeButton.centerY(to: containerView.centerY)
            .pinToSuperview(withSides: .right, andOffset: 0)
        
        containerView.addSubview(textField.prepareForAutolayout())
        textField
            .pinToSuperview(withSides: .left)
            .centerY(to: containerView.centerY)
            .right(to: composeButton.left - 16)
            .height.equal(to: 36)
        
    }
    
    @objc private func didTapComposeComment() {
        let comment = (textField.text ?? "").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if comment.count > 0 {
            NotificationCenter.default.notifyPostComment(withComment: comment)
        }
    }
}
