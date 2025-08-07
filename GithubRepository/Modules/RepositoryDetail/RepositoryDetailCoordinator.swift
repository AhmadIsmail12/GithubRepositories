//
//  RepositoryDetailCoordinator.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

final class RepositoryDetailCoordinator {
    
    private let diContainer: RepositorDetailDIContainer
    
    init(diContainer: RepositorDetailDIContainer) {
        self.diContainer = diContainer
    }

    func createRepositoryDetail(repository: Repository) -> RepositoryDetailView {
        let view = diContainer.makeRepositorDetailView(repository: repository)
        return view
    }
}
