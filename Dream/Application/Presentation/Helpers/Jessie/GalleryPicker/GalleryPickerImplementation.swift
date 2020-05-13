//
//  GalleryPickerImplementation.swift
//

import UIKit

// MARK: - GalleryPickerImplementation

class GalleryPickerImplementation: NSObject {
    
    // MARK: - Properties
    
    /// Current UIViewController for presenting UIImagePickerController (which holds UIImagePickerController instance)
    private weak var viewController: UIViewController?
    
    /// This block will be called with UIViewController.dismiss for the current UIImagePickerController
    private var dismissBlock: GalleryPickerDismissBlock?
    
    /// This block will be called after choosing of some item in the gallery
    private var pickingBlock: GalleryPickerMainBlock?
    
    /// Current UIImagePickerController instance (if exists)
    private weak var picker: UIImagePickerController?
    
    /// allowsEditing flag for the UIImagePickerController
    private(set) var allowsEditing: Bool?
    
    /// sourceType flag for the UIImagePickerController
    private(set) var sourceType: UIImagePickerController.SourceType?
    
    /// mediaTypes flag for the UIImagePickerController
    private(set) var mediaTypes: [String]?
    
    /// videoMaximumDuration flag for the UIImagePickerController
    private(set) var videoMaximumDuration: Foundation.TimeInterval?
    
    /// videoQuality flag for the UIImagePickerController
    private(set) var videoQuality: UIImagePickerController.QualityType?
    
    /// showsCameraControls flag for the UIImagePickerController
    private(set) var showsCameraControls: Bool?
    
    /// cameraOverlayView flag for the UIImagePickerController
    private(set) var cameraOverlayView: UIView?
    
    /// cameraViewTransform flag for the UIImagePickerController
    private(set) var cameraViewTransform: CGAffineTransform?
    
    /// cameraCaptureMode flag for the UIImagePickerController
    private(set) var cameraCaptureMode: UIImagePickerController.CameraCaptureMode?
    
    /// cameraDevice flag for the UIImagePickerController
    private(set) var cameraDevice: UIImagePickerController.CameraDevice?
    
    /// cameraFlashMode flag for the UIImagePickerController
    private(set) var cameraFlashMode: UIImagePickerController.CameraFlashMode?
    
    /// Present UIImagePickerController instance
    private func show() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let imagePicker = UIImagePickerController()
            self.picker = imagePicker
            imagePicker.delegate = self
            self.setProperties()
            self.viewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /// Dismiss UIImagePickerController instance
    private func close() {
        picker?.dismiss(animated: true, completion: dismissBlock)
    }
    
    /// Set all properties which helps us to setup UIImagePickerController
    private func setProperties() {
        if let allowsEditing = allowsEditing {
            picker?.allowsEditing = allowsEditing
        }
        if let sourceType = sourceType {
            picker?.sourceType = sourceType
        }
        if let mediaTypes = mediaTypes {
            picker?.mediaTypes = mediaTypes
        }
        if let videoMaximumDuration = videoMaximumDuration {
            picker?.videoMaximumDuration = videoMaximumDuration
        }
        if let videoQuality = videoQuality {
            picker?.videoQuality = videoQuality
        }
        if let showsCameraControls = showsCameraControls {
            picker?.showsCameraControls = showsCameraControls
        }
        if let cameraOverlayView = cameraOverlayView {
            picker?.cameraOverlayView = cameraOverlayView
        }
        if let cameraViewTransform = cameraViewTransform {
            picker?.cameraViewTransform = cameraViewTransform
        }
        if let cameraCaptureMode = cameraCaptureMode {
            picker?.cameraCaptureMode = cameraCaptureMode
        }
        if let cameraDevice = cameraDevice {
            picker?.cameraDevice = cameraDevice
        }
        if let cameraFlashMode = cameraFlashMode {
            picker?.cameraFlashMode = cameraFlashMode
        }
    }
    
    /// Reset all properties which helps us to setup UIImagePickerController
    private func resetProperties() {
        videoMaximumDuration = nil
        showsCameraControls = nil
        cameraViewTransform = nil
        cameraOverlayView = nil
        cameraCaptureMode = nil
        cameraFlashMode = nil
        allowsEditing = nil
        dismissBlock = nil
        pickingBlock = nil
        videoQuality = nil
        cameraDevice = nil
        sourceType = nil
        mediaTypes = nil
    }
}

extension GalleryPickerImplementation: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        pickingBlock?(
            GalleryItem(
                originalImage: info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                editedImage:   info[UIImagePickerController.InfoKey.editedImage]   as? UIImage,
                referenceURL:  info[UIImagePickerController.InfoKey.referenceURL]  as? URL,
                mediaType:     info[UIImagePickerController.InfoKey.mediaType]     as? String
            )
        )
        close()
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        close()
    }
}

// MARK: - GalleryPicker

extension GalleryPickerImplementation: GalleryPicker {
    
    func allowsEditing(_ allowsEditing: Bool) -> Self {
        self.allowsEditing = allowsEditing
        return self
    }
    
    func showsCameraControls(_ showsCameraControls: Bool) -> Self {
        self.showsCameraControls = showsCameraControls
        return self
    }
    
    func cameraViewTransform(_ cameraViewTransform: CGAffineTransform) -> Self {
        self.cameraViewTransform = cameraViewTransform
        return self
    }
    
    func cameraOverlayView(_ cameraOverlayView: UIView) -> Self {
        self.cameraOverlayView = cameraOverlayView
        return self
    }
    
    func cameraCaptureMode(_ cameraCaptureMode: UIImagePickerController.CameraCaptureMode) -> Self {
        self.cameraCaptureMode = cameraCaptureMode
        return self
    }
    
    func cameraFlashMode(_ cameraFlashMode: UIImagePickerController.CameraFlashMode) -> Self {
        self.cameraFlashMode = cameraFlashMode
        return self
    }
    
    func videoQuality(_ videoQuality: UIImagePickerController.QualityType) -> Self {
        self.videoQuality = videoQuality
        return self
    }
    
    func cameraDevice(_ cameraDevice: UIImagePickerController.CameraDevice) -> Self {
        self.cameraDevice = cameraDevice
        return self
    }
    
    func sourceType(_ sourceType: UIImagePickerController.SourceType) -> Self {
        self.sourceType = sourceType
        return self
    }
    
    func mediaTypes(_ mediaTypes: [String]) -> Self {
        self.mediaTypes = mediaTypes
        return self
    }
    
    func videoMaximumDuration(_ videoMaximumDuration: Foundation.TimeInterval) -> Self {
        self.videoMaximumDuration = videoMaximumDuration
        return self
    }
    
    func show(in controller: UIViewController, picking: @escaping GalleryPickerMainBlock, dismiss: GalleryPickerDismissBlock?) {
        pickingBlock   = picking
        dismissBlock   = dismiss
        viewController = controller
        show()
    }
}
