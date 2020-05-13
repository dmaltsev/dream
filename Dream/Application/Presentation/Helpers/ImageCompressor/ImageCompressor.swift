//
//  ImageCompressor.swift
//  Мечта.ру
//

import Foundation

// MARK: - CompressionMeasure

enum CompressionMeasure {

    case bytes(Int)
    case kilobytes(Double)
    case megabytes(Double)

    var asBytes: Int {
        switch self {
        case .bytes(let bytes):
            return bytes
        case .kilobytes(let kilobytes):
            return Int(kilobytes * 1024)
        case .megabytes(let megabytes):
            return Int(megabytes * 1024 * 1024)
        }
    }
}

// MARK: - ImageCompressionError

enum ImageCompressionError: Error {

    case dataConvertionNotAvailable(compressionQuality: CGFloat)
}

extension ImageCompressionError: LocalizedError {

    var failureReason: String? {
        switch self {
        case .dataConvertionNotAvailable(compressionQuality: let quality):
            return "Cannot convert the given image to data with a compression quality = \(quality)"
        }
    }
}

// MARK: - ImageCompressor

protocol ImageCompressor {

    /// Compress the given image to a necessary size
    ///
    /// - Parameters:
    ///   - image: some image
    ///   - measure: measure for compressing
    ///   - completion: completion block
    func compress(
        image: UIImage,
        toMeasure measure: CompressionMeasure,
        completion: @escaping (Result<Data, ImageCompressionError>) -> Void
    )
}

// MARK: - ImageCompressorImplementation

final class ImageCompressorImplementation {

    // MARK: - Properties

    /// Target queue for the compressing action
    private let queue: DispatchQueue

    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter queue: target queue for the compressing action
    init(queue: DispatchQueue) {
        self.queue = queue
    }

    /// Plain initializer
    convenience init() {
        self.init(queue: DispatchQueue(label: "image-compressor"))
    }
}

// MARK: - ImageCompressor

extension ImageCompressorImplementation: ImageCompressor {

    func compress(
        image: UIImage,
        toMeasure measure: CompressionMeasure,
        completion: @escaping (Result<Data, ImageCompressionError>) -> Void
    ) {
        queue.async {
            let sizeInBytes = measure.asBytes
            var needCompress = true
            var imgData: Data?
            var compressingValue: CGFloat = 0.99
            while (needCompress && compressingValue > 0.0) {
                guard let data = image.jpegData(compressionQuality: compressingValue) else {
                    completion(.failure(.dataConvertionNotAvailable(compressionQuality: compressingValue)))
                    return
                }
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
            completion(.success(imgData.unwrap()))
        }
    }
}
