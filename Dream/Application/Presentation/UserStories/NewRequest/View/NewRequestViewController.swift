//
//  NewRequestViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import YPImagePicker

// MARK: - NewRequestViewController

class NewRequestViewController: UIViewController {
    
    private var selectedAttachmentView: AttachmentView?
    
    // MARK: - Properties
    private lazy var attachmentViews: [AttachmentView] = {
        var views: [AttachmentView] = []
        for i in 0..<6 { views.append(AttachmentView()) }
        views.forEach { $0.delegate = self }
        return views
    }()
    
    private let attachmentsGrid: GridComponent = {
        let gridComponent = GridComponent(rowSize: 3, rowHeight: 169)
        return gridComponent
    }()
    
    private let nameField: LabelTextField = {
        let field = LabelTextField(title: loc("name"))
        return field
    }()
    
    private let ageField: LabelTextField = {
        let field = LabelTextField(title: loc("age"))
        return field
    }()
    
    private let goodieField: LabelTextField = {
        let field = LabelTextField(title: loc("help_to_choose"))
        return field
    }()
    
    private let purposeField: LabelTextField = {
        let field = LabelTextField(title: loc("for"))
        return field
    }()
    
    private let createButton: UIButton = {
        let button = GradientButton()
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        return button
    }()

    /// Presenter instance
    var output: NewRequestViewOutput?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
    }

    // MARK: - Private
    
    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func setupAttachmentsGrid() {
        self.view.addSubview(attachmentsGrid.prepareForAutolayout())
        attachmentsGrid.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .top(to: purposeField.bottom + 16)
        attachmentViews.forEach { attachmentsGrid.addCell(view: $0) }
    }
    
    private func setupViews() {
        self.view.addSubview(nameField.prepareForAutolayout())
        nameField.pinToSuperview(withSides: .left, andOffset: 20)
            .width(equalTo: self.view.width, multiplier: 0.5)
            .top(to: self.view.top + 64)
            .height.equal(to: 36)
        
        self.view.addSubview(ageField.prepareForAutolayout())
        ageField.pinToSuperview(withSides: .right, andOffset: 20)
            .top(to: self.view.top + 64)
            .left(to: nameField.right + 16)
            .height.equal(to: 36)
        
        self.view.addSubview(goodieField.prepareForAutolayout())
        goodieField.pinToSuperview(withSides: .left, .right, andOffset: 20).top(to: nameField.bottom + 16)
            .height.equal(to: 36)
        
        self.view.addSubview(purposeField.prepareForAutolayout())
        purposeField.pinToSuperview(withSides: .left, .right, andOffset: 20).top(to: goodieField.bottom + 16)
            .height.equal(to: 36)
    }
    
    private func setupCreateButton() {
        self.view.addSubview(createButton.prepareForAutolayout())
        createButton.pinToSuperview(withSides: .left, .right, andOffset: 20).top(to: attachmentsGrid.bottom + 32)
            .height.equal(to: 56)
        
        createButton.addTarget(self, action: #selector(didPressCreatePost), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "IconClose"), style: .plain, target: self, action: #selector(close))
    }
    
    @objc private func close() {
        self.closeCurrentModule(animated: true)
    }
    
    @objc private func didPressCreatePost() {
        let goodie = goodieField.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let purpose = purposeField.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let description = "\(goodie) для \(purpose)"
        let images = attachmentViews.compactMap { $0.image }
        
        self.output?.didTriggerCreatePost(name: "", age: 10, description: description, media: images)
    }
    
}

// MARK: - NewRequestViewInput

extension NewRequestViewController: NewRequestViewInput {
    
    func setupInitialState() {
        setupNavigationBar()
        setupView()
        setupViews()
        setupAttachmentsGrid()
        setupCreateButton()
    }
    
    func update(brand: String, withImage image: UIImage?) {
        if let attachmentView = self.selectedAttachmentView {
            attachmentView.image = image
        }
    }
}

// MARK: - ViperViewOutputProvider

extension NewRequestViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}

extension NewRequestViewController : AttachmentViewDelegate {
    
    func didSelectAddAttachment(inAttachmentView attachmentView: AttachmentView) {
        var config = YPImagePickerConfiguration()
        config.onlySquareImagesFromCamera = false
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = false
        config.hidesStatusBar = false
        config.library.isSquareByDefault = false
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker, weak self] items, _ in
            if let photo = items.singlePhoto {
                self?.selectedAttachmentView = attachmentView
                picker.dismiss(animated: true) {
                    self?.output?.didTriggerSetMediaBrand(withMediaImage: photo.image)
                }
            } else {
                picker.dismiss(animated: true)
            }
        }
        present(picker, animated: true, completion: nil)
    }
    
    func didSelectRemoveAttachment(inAttachmentView attachmentView: AttachmentView) {
        attachmentView.image = nil
    }
        
}
