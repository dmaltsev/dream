//
//  NetworkCache.swift
//  
//
//  Created by denis on 26/06/2019.
//

import Foundation

class NetworkCache {
    
    static func readCache(fromFile file: String) -> String? {
        let cacheTimeout:Double = 3 * 30
        let directoryURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard let directoryURL = directoryURLs.first else {
            return nil
        }
        let fileURL = directoryURL.appendingPathComponent("responseCache").appendingPathComponent(file)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            var isOutdatedCache = false
            if let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path), let modificationDate = attributes[FileAttributeKey.modificationDate] as? Date {
                isOutdatedCache = (Date().timeIntervalSince1970 - modificationDate.timeIntervalSince1970) > cacheTimeout
            }
            guard let data = FileManager.default.contents(atPath: fileURL.path), let string = String(data: data, encoding: .utf8), isOutdatedCache == false else {
                return nil
            }
            return string
        }
        return nil
    }
    
    static func writeCache(toFile file: String, data: String)  {
        let directoryURLs = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        guard let directoryURL = directoryURLs.first else {
            return
        }
        let fileURL = directoryURL.appendingPathComponent("responseCache")
        try? FileManager.default.createDirectory(at: fileURL, withIntermediateDirectories: true, attributes: nil)
        
        guard let utf8Data = data.data(using: .utf8) else {
            return
        }
        
        let url = fileURL.appendingPathComponent(file)
        try? utf8Data.write(to: url)
    }
    
}
