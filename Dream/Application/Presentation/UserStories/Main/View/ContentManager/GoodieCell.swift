//
//  GoodieCell.swift
//  Dream
//
//  Created by denis on 26/10/2019.
//  Copyright © 2019 Unknown. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class GoodieCell : UICollectionViewCell {
    
    private(set) var disposeOnReuseBag = DisposeBag()
    
    private lazy var mediaService: MediaService = MediaServiceImplementation()
    
    static let identifier = "GoodieCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.startAnimating()
        return loader
    }()
    
    private let checkmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "MarkUnchecked"), for: .normal)
        return button
    }()
    
    private let votesCount: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    private let leftOrLabel: UILabel = {
        let label = UILabel()
        label.text = loc("or")
        label.layer.cornerRadius = 16
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.textColor = .darkTextColor
        label.font = UIFont.mediumFont(of: 11)
        label.textAlignment = .center
        return label
    }()
    
    private let rightOrLabel: UILabel = {
        let label = UILabel()
        label.text = loc("or")
        label.layer.cornerRadius = 16
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.textColor = .darkTextColor
        label.font = UIFont.mediumFont(of: 11)
        label.textAlignment = .center
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
        imageView.pinToSuperview(withSides: .top).pinToSuperview(withSides: .left, .right, andOffset: 6)
        
        containerView.addSubview(loader.prepareForAutolayout())
        loader.center(in: imageView)
        
        containerView.addSubview(checkmarkButton.prepareForAutolayout())
        checkmarkButton.centerX(to: containerView.centerX).size(width: 32, height: 32)
            .top(to: imageView.bottom + 6)
            .pinToSuperview(withSides: .bottom)
        checkmarkButton.addTarget(self, action: #selector(didCheckMarkPress), for: .touchUpInside)
        
        containerView.addSubview(votesCount.prepareForAutolayout())
        votesCount.centerY(to: checkmarkButton.centerY).left(to: checkmarkButton.right + 12)
        
        containerView.addSubview(leftOrLabel.prepareForAutolayout())
        leftOrLabel.centerY(to: imageView.centerY)
            .size(width: 32, height: 32)
            .pinToSuperview(withSides: .left, andOffset: -16)
        
        containerView.addSubview(rightOrLabel.prepareForAutolayout())
        rightOrLabel.centerY(to: imageView.centerY)
            .size(width: 32, height: 32)
            .pinToSuperview(withSides: .right, andOffset: -16)
    }
    
    func setup(withModel viewModel: ImageCellModel, isFirst: Bool = false, isLast: Bool = false) {
        imageView.image = nil
        mediaService.obtainMediaDetails(forMediaId: viewModel.media.id).map { $0?.url }.filterNil()
            .map { URL(string: "\(ApiConfig.imagesUrl)\($0)") }.filterNil()
            .bind(to: imageView.rx.setImage)
            .disposed(by: self.disposeOnReuseBag)
        
        leftOrLabel.isHidden = isFirst
        rightOrLabel.isHidden = isLast
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeOnReuseBag = DisposeBag()
    }
    
    @objc private func didCheckMarkPress() {
        
    }
}

extension Reactive where Base : UIImageView {
    func setImage(_ source: Observable<URL>) -> Disposable {
        return source.bind(onNext: { [weak base] url in
            base?.af_setImage(withURL: url)
        })
    }
}
