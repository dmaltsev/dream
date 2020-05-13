//
//  ApiClient.swift
//  Dream
//
//  Created by denis on 09.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper
import Alamofire_Synchronous
import ObjectMapper
import CoreLocation

class ApiClient {
    
    static let sharedInstance = ApiClient()
    
    private let imageDownloader: ImageDownloader!
    private let alamofireManager: SessionManager!
    
    init() {
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpCookieStorage = nil
        sessionConfiguration.timeoutIntervalForRequest = 100 //10
        sessionConfiguration.timeoutIntervalForResource = 100//10
        sessionConfiguration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        sessionConfiguration.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol1
        self.alamofireManager = Alamofire.SessionManager(configuration: sessionConfiguration)

        
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .never
        configuration.httpShouldSetCookies = false
        configuration.httpCookieStorage = nil
        configuration.timeoutIntervalForRequest = 100//10
        configuration.timeoutIntervalForResource = 100//10
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol1
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: Alamofire.SessionManager.default.delegate, serverTrustPolicyManager: nil)
        
        imageDownloader = ImageDownloader(sessionManager: sessionManager)
    }
    
    func performSyncRequest<T:BaseNetworkResponse>(request: ApiRouter, responseType:T.Type) -> (T?, NSError?) {
        let dataRequest = self.alamofireManager.request(request)
        let responseString = dataRequest.responseString()
        if let error = responseString.error {
            return (nil, error as NSError)
        } else if let jsonString = responseString.value {
            let response = Mapper<T>().map(JSONString: jsonString)
            return (response, nil)
        } else {
            return (nil, nil)
        }
    }
    
    func performRequest<T:BaseNetworkResponse>(request: ApiRouter, responseHandler:@escaping (T) -> (Void),
                        errorHandler:@escaping (NSError) -> (Void)) {
        let dataRequest = self.alamofireManager.request(request)
        dataRequest.responseString { response in
            print(response.result.value)
        }.responseObject { (response:DataResponse<T>) in
            if let error = response.error {
                errorHandler(error as NSError)
            } else if let result = response.result.value {
                responseHandler(result)
            } else {
                errorHandler(NSError.init(domain: "", code: 1, userInfo: nil))
            }
        }
    }
    
    func performRequest(request: ApiRouter, responseHandler:@escaping (String?) -> (Void)) {
        let dataRequest = self.alamofireManager.request(request)
        dataRequest.responseString { response in
            responseHandler(response.result.value)
        }
    }
    
    func performRequest<T:BaseNetworkResponse>(request: URLRequestConvertible, responseHandler:@escaping (T) -> (Void),
                                               errorHandler:@escaping (NSError) -> (Void)) {
        let dataRequest = self.alamofireManager.request(request)
        dataRequest.response(completionHandler: { (response) in
            dataRequest.responseObject { (response:DataResponse<T>) in
                if let error = response.error {
                    errorHandler(error as NSError)
                } else if let result = response.result.value {
                    responseHandler(result)
                } else {
                    errorHandler(NSError.init(domain: "", code: 1, userInfo: nil))
                }
            }
        })
    }
    
    func performSyncMultipartRequest<T:BaseNetworkResponse>(request: ApiRouter, multipartFormData: MultipartFormData, responseType:T.Type) -> (T?, NSError?) {
        let data = try! multipartFormData.encode()
        let uploadRequest = alamofireManager.upload(data, with: request)
        let responseString = uploadRequest.responseString()
        let result = responseString.result
        
        switch result {
            case .success(_):
                return (nil, nil)
            case .failure(let error):
                return (nil, error as NSError)
        }
    }
    
    func performMultipartRequest<T:BaseNetworkResponse>(request: ApiRouter, params:[String : Any], responseHandler:@escaping (T) -> (Void),
                        errorHandler:@escaping (NSError) -> (Void)) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for param in params {
                let key = param.key
                let value = param.value
                if value is [Data] {
                    let dataArray = value as! [Data]
                    for item in dataArray {
                        multipartFormData.append(item, withName: key, fileName: "\(UUID().uuidString.lowercased()).jpg", mimeType: "image/jpg")
                    }
                } else if value is Data {
                    multipartFormData.append(value as! Data, withName: key, fileName: "\(UUID().uuidString.lowercased()).jpg", mimeType: "image/jpg")
                } else if value is String {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                } else if value is Int {
                    multipartFormData.append( "\(value as! Int)".data(using: .utf8)!, withName: key)
                }
            }
            
        }, with: request) { (result) in
            switch result {
            case .success(let uploadRequest, _, _):
                uploadRequest.responseObject { (response:DataResponse<T>) in
                    if let error = response.error {
                        errorHandler(error as NSError)
                    } else if let result = response.result.value {
                        responseHandler(result)
                    } else {
                        errorHandler(NSError.init(domain: "", code: 1, userInfo: nil))
                    }
                }
            case .failure(let error):
                errorHandler(error as NSError)
                break
            }
        }
    }
    
//    func downloadFile(withURL url: URL, completion:@escaping ((URL?, Error?) -> (Void))) {
//        let fileName = url.absoluteString.fileNameWithExtension
//        let fileExtension = fileName.fileExtension
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            if let fileExtension = fileExtension, fileExtension.count > 0, fileExtension != fileName {
//                let fileURL = documentsURL.appendingPathComponent(fileName)
//                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//            } else {
//                let fileURL = documentsURL.appendingPathComponent("\(UUID.init().uuidString).jpg")
//                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//            }
//        }
//        var headers: HTTPHeaders = [ ApiHeader.authorization : ApiConfig.authHeader]
//
//        if let cookie = UserDefaults.standard.string(forKey: Defaults.Cookie) {
//            headers["Cookie"] = cookie
//        }
//
//        Alamofire.download(url, method: .get, parameters: nil,
//            encoding: URLEncoding(),
//            headers: headers,
//            to: destination).downloadProgress(closure: { (progress) in
//                //progress closure
//            }).response(completionHandler: { (response) in
//                let destinationURL = response.destinationURL
//                let error = response.error
//                completion(destinationURL, error)
//            })
//    }
    
//    func downloadImage(imageView: UIImageView, image: URL, placeholder: UIImage? = nil) {
//        var request = URLRequest(url: image)
//        let versionBundle = getVersionAndBuild()
//        request.addValue(versionBundle.0, forHTTPHeaderField: ApiHeader.appVersion)
//        request.addValue(versionBundle.1, forHTTPHeaderField: ApiHeader.appBuild)
//        request.addValue("iOS", forHTTPHeaderField: ApiHeader.appOS)
//        request.addValue(ApiConfig.authHeader, forHTTPHeaderField: ApiHeader.authorization)
//
//        if let cookie = UserDefaults.standard.string(forKey: Defaults.Cookie) {
//            request.addValue(cookie, forHTTPHeaderField: "Cookie")
//        }
//
//        imageView.af_imageDownloader = self.imageDownloader
//        imageView.af_setImage(withURLRequest: request, placeholderImage: placeholder) { (response) in
//            if response.error != nil {
//                let urlString = image.absoluteString
//                if urlString.hasPrefix(ApiConfig.avatarIconsUrl) && !urlString.hasPrefix(ApiConfig.avatarIconsUrlNew) {
//                    ApiClient.sharedInstance.downloadImage(imageView: imageView,
//                                                           image: URL(string: urlString.replacingOccurrences(of: ApiConfig.avatarIconsUrl,
//                                                                                                          with: ApiConfig.avatarIconsUrlNew))!)
//                }
//            }
//        }
//    }
//
//    func downloadImage(image: URL, completion: @escaping ((UIImage?) -> (Void))) {
//        var request = URLRequest(url: image)
//        let versionBundle = getVersionAndBuild()
//        request.addValue(versionBundle.0, forHTTPHeaderField: ApiHeader.appVersion)
//        request.addValue(versionBundle.1, forHTTPHeaderField: ApiHeader.appBuild)
//        request.addValue("iOS", forHTTPHeaderField: ApiHeader.appOS)
//        request.addValue(ApiConfig.authHeader, forHTTPHeaderField: ApiHeader.authorization)
//
//        if let cookie = UserDefaults.standard.string(forKey: Defaults.Cookie) {
//            request.addValue(cookie, forHTTPHeaderField: "Cookie")
//        }
//
//        self.imageDownloader.download(request) { result in
//            completion(result.value)
//        }
//
//
//    }
//
//    func request(forImage image: URL) -> URLRequest {
//        var request = URLRequest(url: image)
//        let versionBundle = getVersionAndBuild()
//        request.addValue(ApiConfig.authHeader, forHTTPHeaderField: ApiHeader.authorization)
//        request.addValue(versionBundle.0, forHTTPHeaderField: ApiHeader.appVersion)
//        request.addValue(versionBundle.1, forHTTPHeaderField: ApiHeader.appBuild)
//        request.addValue("iOS", forHTTPHeaderField: ApiHeader.appOS)
//        return request
//    }
    
}
