//
//  RepositorDetailDIContainer.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

final class RepositorDetailDIContainer: AppDIContainer {
    
    func makeRepositoryDetailViewModel(repository: Repository) -> RepositoryDetailViewModel {
        return RepositoryDetailViewModel(
            repository: repository
        )
    }

    func makeRepositorDetailView(repository: Repository) -> RepositoryDetailView {
        return RepositoryDetailView(
            viewModel: self.makeRepositoryDetailViewModel(
                repository: repository
            )
        )
    }
}
