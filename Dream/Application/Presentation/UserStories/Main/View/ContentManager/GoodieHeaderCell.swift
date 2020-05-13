//
//  GoodieHeaderCell.swift
//  Dream
//
//  Created by denis on 26/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GoodieHeaderCell : UICollectionViewCell {
    
    private(set) var disposeOnReuseBag = DisposeBag()
    
    private lazy var userService: UserService = UserServiceImplementation()
    
    static let identifier = "GoodieHeaderCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test test test test test"
        label.textColor = .darkTextColor
        label.font = UIFont.regularFont(of: 13)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        return label
    }()
    
    private let commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Comments")
        return imageView
    }()
    
    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        label.font = UIFont.systemFont(ofSize: 11)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
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
        containerView.addSubview(subTitleLabel.prepareForAutolayout())
        containerView.addSubview(commentsImageView.prepareForAutolayout())
        containerView.addSubview(commentsCountLabel.prepareForAutolayout())
        
        commentsImageView.pinToSuperview(withSides: .right, andOffset: 20)
            .width.equal(to: 16)
        commentsImageView.height.equal(to: 16)
        
        titleLabel.pinToSuperview(withSides: .left, andOffset: 20)
            .right(to: commentsImageView.left - 16)
            .pinToSuperview(withSides: .top)
        subTitleLabel.pinToSuperview(withSides: .left, andOffset: 20)
            .right(to: commentsCountLabel.left - 16)
            .pinToSuperview(withSides: .bottom)
        
        commentsImageView.centerY(to: titleLabel.centerY + 2)
        commentsCountLabel.centerX(to: commentsImageView.centerX)
            .centerY(to: subTitleLabel.centerY - 2)
    }
    
    func setup(withModel model: HeaderCellModel) {
        guard let post = model.post else {
            return
        }
        userService.obtainUser(withUserId: post.userId).filterNil()
            .map { user -> NSAttributedString in
                let attributedString = NSMutableAttributedString(string: "\(user.name), \(user.age)")
                attributedString.addAttribute(.font, value: UIFont.regularFont(of: 22), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(.font, value: UIFont.mediumFont(of: 22), range: NSMakeRange(0, user.name.count))
                return NSAttributedString(attributedString: attributedString)
            }
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: self.disposeOnReuseBag)
        
        subTitleLabel.text = post.description
        commentsCountLabel.text = "\(post.commentCount)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuseBag = DisposeBag()
    }
}
