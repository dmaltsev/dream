//
//  AttachmentView.swift
//  Dream
//
//  Created by denis on 07.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import UIKit

protocol AttachmentViewDelegate : class {
    func didSelectAddAttachment(inAttachmentView attachmentView: AttachmentView)
    func didSelectRemoveAttachment(inAttachmentView attachmentView: AttachmentView)
}

class AttachmentView : UIView {
    
    weak var delegate: AttachmentViewDelegate?
    
    var image: UIImage? {
        didSet {
            contentImageView.image = image
            backgroundImageView.isHidden = image != nil
            actionButton.setImage(UIImage(named: image == nil ? "AttachmentAdd" : "AttachmentRemove"), for: .normal)
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AttachmentBackground"))
        return imageView
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "AttachmentAdd"), for: .normal)
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        button.size(width: 38, height: 38)
        
        button.layer.shadowPath =
              UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 38, height: 38),
              cornerRadius: 19).cgPath
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 1
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(backgroundImageView.prepareForAutolayout())
        backgroundImageView.pinToSuperview(excluding: .bottom).pinToSuperview(withSides: .bottom, andOffset: 9)
        
        self.addSubview(contentImageView.prepareForAutolayout())
        contentImageView.left(to: backgroundImageView.left)
            .right(to: backgroundImageView.right)
            .top(to: backgroundImageView.top)
            .bottom(to: backgroundImageView.bottom)
        
        self.addSubview(actionButton.prepareForAutolayout())
        actionButton.pinToSuperview(withSides: .bottom).centerX(to: self.centerX)
    }
    
    @objc private func didTapActionButton() {
        if image == nil {
            self.delegate?.didSelectAddAttachment(inAttachmentView: self)
        } else {
            self.delegate?.didSelectRemoveAttachment(inAttachmentView: self)
        }
    }
    
}
