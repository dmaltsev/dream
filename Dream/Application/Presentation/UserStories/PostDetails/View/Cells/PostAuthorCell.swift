//
//  PostAuthorCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostAuthorCell : UICollectionViewCell {
    
    private(set) var disposeOnReuseBag = DisposeBag()
    
    private lazy var userService: UserService = UserServiceImplementation()
    
    static let identifier = "PostAuthorCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
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
    
    func setup(withModel model: PostAuthorCellModel) {
        userService.obtainUser(withUserId: model.post.userId).filterNil()
            .map { user -> NSAttributedString in
                let attributedString = NSMutableAttributedString(string: "\(user.name), \(user.age)")
                attributedString.addAttribute(.font, value: UIFont.regularFont(of: 22), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(.font, value: UIFont.mediumFont(of: 22), range: NSMakeRange(0, user.name.count))
                return NSAttributedString(attributedString: attributedString)
            }
            .bind(to: titleLabel.rx.attributedText)
            .disposed(by: self.disposeOnReuseBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuseBag = DisposeBag()
    }
}
