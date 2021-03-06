//
//  PostMediaImageCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AlamofireImage
import UIKit

class PostMediaImageCell : UICollectionViewCell {
    
    private var mediaId: String?
    
    private(set) var disposeOnReuseBag = DisposeBag()
    
    private lazy var mediaService: MediaService = MediaServiceImplementation()
    
    static let identifier = "PostMediaImageCell"
    
    private let mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeButtonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 39
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.shadowPath =
              UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 78, height: 78),
              cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "PostMediaRateButton"), for: .normal)
        button.addTarget(self, action: #selector(didPressVote), for: .touchUpInside)
        return button
    }()
    
    static let reuseIdentifier = "MediaPageCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.shadowRadius = 0
        self.contentView.backgroundColor = .white
        setupMediaImageView()
        setupLikeView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMediaImageView() {
        self.contentView.addSubview(mediaImageView.prepareForAutolayout())
        mediaImageView.pinToSuperview(withOffset: 12)
    }
    
    private func setupLikeView() {
        self.contentView.addSubview(likeButtonView.prepareForAutolayout())
        likeButtonView.right(to: mediaImageView.right - 12)
            .pinToSuperview(withSides: .bottom, andOffset: 3)
            .height.equal(to: 78)
        likeButtonView.width.equal(to: 78)
        
        likeButtonView.addSubview(likeButton.prepareForAutolayout())
        likeButton.centerY(to: likeButtonView.centerY)
            .pinToSuperview(withSides: .left, andOffset: 15)
    }
    
    func setup(withModel model: MediaImageCellModel) {
        let media = model.media
        self.mediaId = media.id
        mediaImageView.image = nil
        mediaService.obtainMediaDetails(forMediaId: media.id).map { $0?.url }.filterNil()
            .map { URL(string: "\(ApiConfig.imagesUrl)\($0)") }.filterNil()
            .bind(to: mediaImageView.rx.setImage)
            .disposed(by: self.disposeOnReuseBag)
    }
    
    @objc private func didPressVote() {
        if let mediaId = mediaId {
            NotificationCenter.default.notifyVoteMedia(withMediaId: mediaId)
        }
    }
}


