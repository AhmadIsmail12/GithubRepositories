//
//  RepositoriesListRepository.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation
import Combine

protocol RepositoriesListRepositoryProtocol {
    func searchRepositories(query: String, page: Int) -> AnyPublisher<SearchResponse, Error>
}

final class RepositoriesListRepository: RepositoriesListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func searchRepositories(query: String, page: Int) -> AnyPublisher<SearchResponse, Error> {
        return networkService.request(
            endpoint: .searchRepositories(
                query: query, page: page
            )
        ).map { (response: SearchResponse) in
            response
        }.eraseToAnyPublisher()
    }
}

struct SearchResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    let totalCount: Int
    let items: [Repository]
}
