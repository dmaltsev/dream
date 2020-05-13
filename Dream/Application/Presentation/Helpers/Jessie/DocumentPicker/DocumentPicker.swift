//
//  DocumentPicker.swift
//

import UIKit

// MARK: - DocumentType

enum DocumentType {
    
    case data
    
    var string: String {
        switch self {
        case .data:
            return "public.data"
        }
    }
}

typealias DocumentPickerCancelBlock = () -> ()
typealias DocumentPickerDocumentBlock = (URL) -> ()
typealias DocumentPickerDocumentsBlock = ([URL]) -> ()

// MARK: - DocumentPicker

protocol DocumentPicker: class {
    
    /// Show document picker
    ///
    /// - Parameters:
    ///   - documentType: allowed document type
    ///   - mode: picking mode
    func show(in controller: UIViewController, withAnchorView view: UIView?, documentType: DocumentType, mode: UIDocumentPickerMode)
    
    /// Show document picker
    ///
    /// - Parameters:
    ///   - documentTypes: allowed document types
    ///   - mode: picking mode
    func show(in controller: UIViewController, withAnchorView view: UIView?,documentTypes: [DocumentType], mode: UIDocumentPickerMode)
    
    /// Show document picker
    ///
    /// - Parameters:
    ///   - documentTypes: allowed document type
    ///   - mode: picking mode
    func show(in controller: UIViewController,withAnchorView view: UIView?, documentTypes: [String], mode: UIDocumentPickerMode)
    
    /// Add some custom action to the DocumentPicker menu
    ///
    /// - Parameters:
    ///   - title: option title
    ///   - image: option image
    ///   - order: option order
    ///   - handler: handling block
    /// - Returns: Current instance
    @discardableResult func addOption(withTitle title: String, image: UIImage?, order: UIDocumentMenuOrder, handler: @escaping () -> ()) -> Self
    
    /// Cancelled block setter
    ///
    /// - Parameter block: called when picker disappeared
    /// - Returns: Current instance
    @discardableResult func cancelled(_ block: @escaping DocumentPickerCancelBlock) -> Self
    
    /// Pick some document block setter
    ///
    /// - Parameter block: called when some document was picked
    /// - Returns: Current instance
    @discardableResult func pickingDocument(_ block: @escaping DocumentPickerDocumentBlock) -> Self
    
    /// Pick some documents block setter
    ///
    /// - Parameter block: called when some documents was picked
    /// - Returns: Current instance
    @discardableResult func pickingDocuments(_ block: @escaping DocumentPickerDocumentsBlock) -> Self
}
