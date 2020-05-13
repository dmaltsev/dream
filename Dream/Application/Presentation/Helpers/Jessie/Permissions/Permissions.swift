//
//  Permissions.swift
//

import Photos

// MARK: - Permissions

enum Permissions {
    
    // MARK: - Types
    
    typealias RequestPermissionCompletion = (PermissionStatus) -> ()
    
    // MARK: - PermissionStatus
    
    enum PermissionStatus {
        case authorized
        case denied
        case notDetermined
    }
    
    // MARK: - Cases
    
    case gallery
    case camera
    
    // MARK: - Properties
    
    var status: PermissionStatus {
        switch self {
        case .gallery:
            return galleryStatus()
        case .camera:
            return cameraStatus()
        }
    }
    
    // MARK: - Useful
    
    func requestPermissions(_ completion: @escaping RequestPermissionCompletion) {
        switch self {
        case .gallery:
            PHPhotoLibrary.requestAuthorization { _ in
                completion(self.status)
            }
        case .camera:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { _ in
                completion(self.status)
            }
        }
    }
    
    func requestPermissions(success: @escaping () -> (), denied: @escaping () -> ()) {
        switch status {
        case .authorized:
            success()
        case .denied:
            denied()
        default:
            requestPermissions { status in
                if status == .authorized {
                    success()
                } else {
                    denied()
                }
            }
        }
    }
    
    private func galleryStatus() -> PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            fatalError()
        }
    }
    
    private func cameraStatus() -> PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            fatalError()
        }
    }
}
