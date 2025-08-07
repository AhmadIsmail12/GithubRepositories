//
//  RepositoriesListDIContainer.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

final class RepositoriesListDIContainer: AppDIContainer {
    
    func makeRepositoriesListViewModel(
        closures: RepositoriesListViewModelClosures?
    ) -> RepositoriesListViewModel {
        return RepositoriesListViewModel(
            searchUseCase: searchRepositoriesUseCase,
            closures: closures
        )
    }

    func makeRepositoriesListView(
        closures: RepositoriesListViewModelClosures?
    ) -> RepositoriesListView {
        return RepositoriesListView(
            viewModel: self.makeRepositoriesListViewModel(
                closures: closures
            )
        )
    }
}
