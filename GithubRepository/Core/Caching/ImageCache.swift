//
//  ImageCache.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation
import SwiftUI

protocol ImageCacheType {
    func image(forKey key: String) -> UIImage?
    func insertImage(_ image: UIImage?, forKey key: String)
    func removeImage(forKey key: String)
    func removeAll()
}

final class ImageCache: ImageCacheType {
    static let shared = ImageCache()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheURL: URL
    private let expiration: TimeInterval = 5 * 60 // 5 minutes
    
    private init() {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheURL = caches.appendingPathComponent("ImageCache")
        try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
    
    func image(forKey key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        
        if let image = memoryCache.object(forKey: cacheKey) {
            return image
        }
        
        let fileURL = diskCacheURL.appendingPathComponent(key.toFileSafe())
        
        guard fileManager.fileExists(atPath: fileURL.path),
              let attributes = try? fileManager.attributesOfItem(atPath: fileURL.path),
              let modificationDate = attributes[.modificationDate] as? Date,
              Date().timeIntervalSince(modificationDate) < expiration,
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            removeImage(forKey: key)
            return nil
        }
        
        memoryCache.setObject(image, forKey: cacheKey)
        return image
    }
    
    func insertImage(_ image: UIImage?, forKey key: String) {
        let cacheKey = NSString(string: key)
        
        if let image {
            memoryCache.setObject(image, forKey: cacheKey)
            let fileURL = diskCacheURL.appendingPathComponent(key.toFileSafe())
            if let data = image.jpegData(compressionQuality: 1.0) {
                try? data.write(to: fileURL, options: .atomic)
            }
        } else {
            removeImage(forKey: key)
        }
    }
    
    func removeImage(forKey key: String) {
        memoryCache.removeObject(forKey: NSString(string: key))
        let fileURL = diskCacheURL.appendingPathComponent(key.toFileSafe())
        try? fileManager.removeItem(at: fileURL)
    }
    
    func removeAll() {
        memoryCache.removeAllObjects()
        try? fileManager.removeItem(at: diskCacheURL)
        try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
    }
}
