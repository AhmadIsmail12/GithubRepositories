//
//  RepositoriesListAPI.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

struct RepositoriesListAPI {
    static func search(query: String, page: Int) -> String {
        return "/search/repositories?q=org:google+\(query)&page=\(page)"
    }
}
