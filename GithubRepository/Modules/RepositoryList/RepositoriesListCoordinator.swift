//
//  RepositoryListCoordinator.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

protocol RepositoriesListCoordinatorDelegate: AnyObject {
    func didSelect(repository: Repository)
}

final class RepositoriesListCoordinator {
    private let diContainer: RepositoriesListDIContainer
    private var appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator, diContainer: RepositoriesListDIContainer) {
        self.appCoordinator = appCoordinator
        self.diContainer = diContainer
    }

    func createRepositoriesListView() -> RepositoriesListView {
        let respositoriesListView = diContainer.makeRepositoriesListView(
            closures: RepositoriesListViewModelClosures(
                didSelect: showRepositoryDetails
            )
        )
        return respositoriesListView
    }
    
    func showRepositoryDetails(repository: Repository) {
        appCoordinator.push(AppRoute.repositoryDetail(repository))
    }
}
