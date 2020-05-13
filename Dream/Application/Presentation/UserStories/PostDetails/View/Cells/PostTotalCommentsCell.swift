//
//  PostTotalCommentsCell.swift
//  Dream
//
//  Created by denis on 01.04.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

private class ContainerView: UIView {
    
    override func draw(_ rect: CGRect) {
        let width: CGFloat = bounds.width
        let height: CGFloat = bounds.height

        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: width - height, y: bounds.origin.y))
        path.addArc(withCenter: CGPoint(x: width - height, y: height), radius: height, startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: bounds.origin.x, y: height))
        path.close()

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor.commentsBackgroundColor.cgColor

        self.layer.insertSublayer(shape, at: 0)
    }
    
}

class PostTotalCommentsCell : UICollectionViewCell {
    
    static let identifier = "PostTotalCommentsCell"
    
    var containerView: UIView = {
        let view = ContainerView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.contentView.backgroundColor = .white
        self.backgroundColor = .white
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(containerView.prepareForAutolayout())
        containerView.pinToSuperview(withSides: .left, .right)
            .pinToSuperview(withSides: .top, .bottom)
        
        containerView.addSubview(titleLabel.prepareForAutolayout())
        titleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .pinToSuperview(withSides: .bottom)
    }
    
    func setup(withModel model: PostTotalCommentsCellModel) {
        titleLabel.text = "\(model.post.commentCount) комментариев"
    }
}
