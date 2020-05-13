//
//  DocumentPickerImplementation.swift
//

import UIKit

// MARK: - DocumentPickerImplementation

class DocumentPickerImplementation: NSObject {
    
    // MARK: - Properties
    
    fileprivate var documentController: UIDocumentMenuViewController?
    fileprivate weak var controller: UIViewController?
    fileprivate var cancelledBlock: DocumentPickerCancelBlock?
    fileprivate var pickingDocumentBlock: DocumentPickerDocumentBlock?
    fileprivate var pickingDocumentsBlock: DocumentPickerDocumentsBlock?
    fileprivate var extraOption: (title: String, image: UIImage?, order: UIDocumentMenuOrder, handler: () -> ())?
    
    fileprivate func setup() {
        if let (title, image, order, handler) = extraOption {
            documentController?.addOption(withTitle: title, image: image, order: order, handler: handler)
        }
    }
}

// MARK: - DocumentPicker

extension DocumentPickerImplementation: DocumentPicker {

    func show(in controller: UIViewController, withAnchorView view: UIView?, documentType: DocumentType, mode: UIDocumentPickerMode) {
        let documentMenuViewController = UIDocumentMenuViewController(documentTypes: [documentType.string], in: mode)
        documentMenuViewController.delegate = self
        self.documentController = documentMenuViewController
        self.controller = controller
        
        if let presenter = documentMenuViewController.popoverPresentationController, let anchorView = view {
            presenter.sourceView = anchorView
            presenter.sourceRect = anchorView.bounds
        }
        
        setup()
        controller.present(documentMenuViewController, animated: true)
    }
    
    func show(in controller: UIViewController, withAnchorView view: UIView?, documentTypes: [DocumentType], mode: UIDocumentPickerMode) {
        let documentMenuViewController = UIDocumentMenuViewController(documentTypes: documentTypes.map { $0.string }, in: mode)
        documentMenuViewController.delegate = self
        self.documentController = documentMenuViewController
        self.controller = controller
        setup()
        
        if let presenter = documentMenuViewController.popoverPresentationController, let anchorView = view {
            presenter.sourceView = anchorView
            presenter.sourceRect = anchorView.bounds
        }
        
        controller.present(documentMenuViewController, animated: true)
    }
    
    func show(in controller: UIViewController, withAnchorView view: UIView?, documentTypes: [String], mode: UIDocumentPickerMode) {
        let documentMenuViewController = UIDocumentMenuViewController(documentTypes: documentTypes, in: mode)
        documentMenuViewController.delegate = self
        self.documentController = documentMenuViewController
        self.controller = controller
        setup()
        
        if let presenter = documentMenuViewController.popoverPresentationController, let anchorView = view {
            presenter.sourceView = anchorView
            presenter.sourceRect = anchorView.bounds
        }
        
        controller.present(documentMenuViewController, animated: true)
    }

    @discardableResult func addOption(withTitle title: String, image: UIImage?, order: UIDocumentMenuOrder, handler: @escaping () -> ()) -> Self {
        extraOption = (title, image, order, handler)
        return self
    }
    
    @discardableResult func cancelled(_ block: @escaping DocumentPickerCancelBlock) -> Self {
        cancelledBlock = block
        return self
    }
    
    @discardableResult func pickingDocument(_ block: @escaping DocumentPickerDocumentBlock) -> Self {
        pickingDocumentBlock = block
        return self
    }
    
    @discardableResult func pickingDocuments(_ block: @escaping DocumentPickerDocumentsBlock) -> Self {
        pickingDocumentsBlock = block
        return self
    }
}

// MARK: - UIDocumentMenuDelegate

extension DocumentPickerImplementation: UIDocumentMenuDelegate {
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        controller?.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentMenuWasCancelled(_ documentMenu: UIDocumentMenuViewController) {
        cancelledBlock?()
    }
}

// MARK: - UIDocumentPickerDelegate

extension DocumentPickerImplementation: UIDocumentPickerDelegate {

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.controller?.dismiss(animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        pickingDocumentBlock?(url)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        pickingDocumentsBlock?(urls)
    }
}
