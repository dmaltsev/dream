//
//  MediaBrandViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MediaBrandViewController

class MediaBrandViewController: UIViewController {
    
    // MARK: - Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let brandLabelField: LabelTextField = {
        let field = LabelTextField(title: loc("brand"))
        return field
    }()
    
    private let okButton: UIButton = {
        let button = GradientStrokeButton()
        return button
    }()

    /// Presenter instance
    var output: MediaBrandViewOutput?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
    }

    // MARK: - Private
    private func setupBrandImage(withImage image: UIImage?) {
        self.view.addSubview(imageView.prepareForAutolayout())
        imageView.pinToSuperview(withSides: .left, .right, andOffset: 12)
            .pinToSuperview(withSides: .top, andOffset: 76)
            .height(equalTo: self.view.height, multiplier: 526.0 / 812.0)
        imageView.image = image
    }
    
    private func setupBrandLabelField() {
        self.view.addSubview(brandLabelField.prepareForAutolayout())
        brandLabelField.pinToSuperview(withSides: .left, .right, andOffset: 12)
            .top(to: imageView.bottom + 16)
            .height.equal(to: 24)
    }
    
    private func setupOkButton() {
        self.view.addSubview(okButton.prepareForAutolayout())
        okButton.centerX(to: self.view.centerX).size(width: 250, height: 56)
            .top(to: brandLabelField.bottom + 16)
        okButton.addTarget(self, action: #selector(didOkPressed), for: .touchUpInside)
    }
    
    @objc private func didOkPressed() {
        self.output?.didTriggerConfirmBrand(brandLabelField.text)
    }
}

// MARK: - MediaBrandViewInput

extension MediaBrandViewController: MediaBrandViewInput {
    
    func setupInitialState(withImage image: UIImage?) {
        self.view.backgroundColor = .white
        setupBrandImage(withImage: image)
        setupBrandLabelField()
        setupOkButton()
    }
}

// MARK: - ViperViewOutputProvider

extension MediaBrandViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}
