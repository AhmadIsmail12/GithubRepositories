//
//  RepositoryDetailViewModel.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

final class RepositoryDetailViewModel: ObservableObject {
    @Published var repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
}
