//
//  SearchRepositoriesUseCase.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation
import Combine

protocol SearchRepositoriesUseCaseProtocol {
    func execute(query: String, page: Int) -> AnyPublisher<SearchResponse, Error>
}

final class SearchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol {
    private let repository: RepositoriesListRepositoryProtocol

    init(repository: RepositoriesListRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String, page: Int) -> AnyPublisher<SearchResponse, Error> {
        return repository.searchRepositories(
            query: query, page: page
        ).eraseToAnyPublisher()
    }
}
