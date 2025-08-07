//
//  Endpoint.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

enum Endpoint {
    case searchRepositories(query: String, page: Int)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        switch self {
        case .searchRepositories(let query, let page):
            components.path = "/search/repositories"
            components.queryItems = [
                URLQueryItem(name: "q", value: query.isEmpty ? "google" : query),
                URLQueryItem(name: "per_page", value: "20"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
        return components.url
    }
}
