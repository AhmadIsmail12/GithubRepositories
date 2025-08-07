//
//  Repository.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

struct Repository: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case fullName = "full_name"
        case htmlURL = "html_url"
        case createdAt = "created_at"
        case stargazersCount = "stargazers_count"
    }

    let id: Int
    let name: String
    let fullName: String
    let htmlURL: URL
    let createdAt: Date
    let stargazersCount: Int
    let owner: Owner
}


extension Repository {
    static func mock(
        id: Int = 1,
        name: String = "Google Repo",
        fullName: String = "Google",
        htmlURL: URL = URL(string: "https://google.com")!,
        createdAt: Date = Date(),
        owner: Owner = .mock(),
        stargazersCount: Int = 123
    ) -> Repository {
        return Repository(
            id: id,
            name: name,
            fullName: fullName,
            htmlURL: htmlURL,
            createdAt: createdAt,
            stargazersCount: stargazersCount,
            owner: owner
        )
    }
}

