//
//  CacheManager.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()

    private class RepositoryEntry: Codable {
        let value: SearchResponse
        let timestamp: Date
        
        var isExpired: Bool {
            Date().timeIntervalSince(timestamp) > 5 * 60
        }
        
        init(value: SearchResponse, timestamp: Date) {
            self.value = value
            self.timestamp = timestamp
        }
    }
    
    private let memoryCache = NSCache<NSString, RepositoryEntry>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = caches.appendingPathComponent("RepositoriesCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func get(query: String) -> SearchResponse? {
        let key = NSString(string: query)
        // Check memory first
        if let entry = memoryCache.object(forKey: key), !entry.isExpired {
            return entry.value
        }
        // Then disk
        let fileURL = cacheDirectory.appendingPathComponent(query.toFileSafe())
        guard let data = try? Data(contentsOf: fileURL),
              let entry = try? JSONDecoder().decode(RepositoryEntry.self, from: data),
              !entry.isExpired else {
            remove(query: query)
            return nil
        }
        memoryCache.setObject(entry, forKey: key)
        return entry.value
    }
    
    func set(query: String, response: SearchResponse) {
        let entry = RepositoryEntry(value: response, timestamp: Date())
        let key = NSString(string: query)
        memoryCache.setObject(entry, forKey: key)
        let fileURL = cacheDirectory.appendingPathComponent(query.toFileSafe())
        if let data = try? JSONEncoder().encode(entry) {
            try? data.write(to: fileURL)
        }
    }
    
    func remove(query: String) {
        let key = NSString(string: query)
        memoryCache.removeObject(forKey: key)
        let fileURL = cacheDirectory.appendingPathComponent(query.toFileSafe())
        try? fileManager.removeItem(at: fileURL)
    }
    
    func clear() {
        memoryCache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
}

extension String {
    func toFileSafe() -> String {
        addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    }
}
