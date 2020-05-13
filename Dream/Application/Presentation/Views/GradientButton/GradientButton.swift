//
//  GradientButton.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import UIKit

class GradientButton : UIButton {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.buttonOrangeColor.cgColor, UIColor.buttonRedColor.cgColor ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        return gradient
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        if layer == self.layer {
            gradientLayer.frame = self.layer.bounds
        }
        super.layoutSublayers(of: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class GradientStrokeButton : UIButton {
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.buttonOrangeColor.cgColor, UIColor.buttonRedColor.cgColor ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        return gradient
    }()
    
    private let contentLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = true
        return layer
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.layer.addSublayer(gradientLayer)
        self.layer.addSublayer(contentLayer)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        if layer == self.layer {
            gradientLayer.frame = self.layer.bounds
            gradientLayer.cornerRadius = gradientLayer.bounds.height / 2
            contentLayer.frame = self.layer.bounds.inset(by: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
            contentLayer.cornerRadius = contentLayer.bounds.height / 2
        }
        super.layoutSublayers(of: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
