//
//  CommentCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostCommentCell : UICollectionViewCell {
    
    private(set) var disposeOnReuseBag = DisposeBag()
    
    private lazy var userService: UserService = UserServiceImplementation()
    
    static let identifier = "PostCommentCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumFont(of: 16)
        label.textColor = .darkTextColor
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFont(of: 13)
        label.textColor = .darkTextColor
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .commentsBackgroundColor
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(containerView.prepareForAutolayout())
        containerView.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .top, .bottom, andOffset: 3)
        
        containerView.addSubview(titleLabel.prepareForAutolayout())
        titleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .top, andOffset: 16)
        
        containerView.addSubview(subTitleLabel.prepareForAutolayout())
        subTitleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .top(to: titleLabel.bottom + 8)
            .pinToSuperview(withSides: .bottom, andOffset: 16)
    }
    
    func setup(withModel model: CommentCellModel) {
        userService.obtainUser(withUserId: model.comment.userId).filterNil()
            .map { $0.name }
            .bind(to: titleLabel.rx.text)
            .disposed(by: self.disposeOnReuseBag)
        subTitleLabel.text = model.comment.body
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuseBag = DisposeBag()
    }
}
