//
//  GalleryPicker.swift
//

import UIKit

// MARK: - GalleryItem

struct GalleryItem {
    let originalImage: UIImage?
    let editedImage: UIImage?
    let referenceURL: URL?
    let mediaType: String?
}

typealias GalleryPickerMainBlock = (GalleryItem) -> ()
typealias GalleryPickerDismissBlock = () -> ()

// MARK: - GalleryPicker

protocol GalleryPicker: class {
    
    /// Set allowsEditing flag
    ///
    /// - Parameter allowsEditing: allowsEditing flag
    /// - Returns: current instance
    func allowsEditing(_ allowsEditing: Bool) -> Self
    
    /// Set showsCameraControls flag
    ///
    /// - Parameter showsCameraControls: showsCameraControls flag
    /// - Returns: current instance
    func showsCameraControls(_ showsCameraControls: Bool) -> Self
    
    /// Set cameraViewTransform value
    ///
    /// - Parameter cameraViewTransform: cameraViewTransform value
    /// - Returns: current instance
    func cameraViewTransform(_ cameraViewTransform: CGAffineTransform) -> Self
    
    /// Set cameraOverlayView instance
    ///
    /// - Parameter cameraOverlayView: cameraOverlayView instance
    /// - Returns: current instance
    func cameraOverlayView(_ cameraOverlayView: UIView) -> Self
    
    /// Set cameraCaptureMode value
    ///
    /// - Parameter cameraCaptureMode: cameraCaptureMode value
    /// - Returns: current instance
    func cameraCaptureMode(_ cameraCaptureMode: UIImagePickerController.CameraCaptureMode) -> Self
    
    /// Set cameraFlashMode value
    ///
    /// - Parameter cameraFlashMode: cameraFlashMode value
    /// - Returns: current instance
    func cameraFlashMode(_ cameraFlashMode: UIImagePickerController.CameraFlashMode) -> Self
    
    /// Set videoQuality value
    ///
    /// - Parameter videoQuality: videoQuality value
    /// - Returns: current instance
    func videoQuality(_ videoQuality: UIImagePickerController.QualityType) -> Self
    
    /// Set cameraDevice value
    ///
    /// - Parameter cameraDevice: cameraDevice value
    /// - Returns: current instance
    func cameraDevice(_ cameraDevice: UIImagePickerController.CameraDevice) -> Self
    
    /// Set sourceType flag
    ///
    /// - Parameter sourceType: sourceType flag
    /// - Returns: current instance
    func sourceType(_ sourceType: UIImagePickerController.SourceType) -> Self
    
    /// Set mediaTypes
    ///
    /// - Parameter mediaTypes: some mediaTypes
    /// - Returns: current instance
    func mediaTypes(_ mediaTypes: [String]) -> Self
    
    /// Set videoMaximumDuration value
    ///
    /// - Parameter videoMaximumDuration: videoMaximumDuration value
    /// - Returns: current instance
    func videoMaximumDuration(_ videoMaximumDuration: Foundation.TimeInterval) -> Self
    
    /// Show UIImagePickerController
    ///
    /// - Parameters:
    ///   - controller: Parent controller for the UIImagePickerController instance
    ///   - picking: completion block (when user pick something in the gallery)
    ///   - dismiss: dismiss UIImagePickerController block
    func show(in controller: UIViewController, picking: @escaping GalleryPickerMainBlock, dismiss: GalleryPickerDismissBlock?)
}

extension GalleryPicker {
    
    /// Show UIImagePickerController
    ///
    /// - Parameters:
    ///   - controller: Parent controller for the UIImagePickerController instance
    ///   - picking: completion block (when user pick something in the gallery)
    func show(in controller: UIViewController, picking: @escaping GalleryPickerMainBlock) {
        show(in: controller, picking: picking, dismiss: nil)
    }
}
