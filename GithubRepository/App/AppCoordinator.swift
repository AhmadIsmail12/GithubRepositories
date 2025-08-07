//
//  AppCoordinator.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI
import Foundation

final class AppCoordinator: ObservableObject {
    
    let diContainer: AppDIContainer
    @Published public var path = NavigationPath()
    @Published var isShowingSplash = true

    init(diContainer: AppDIContainer) {
        self.diContainer = diContainer
    }

    func start() -> SplashView {
        let container = diContainer.makeSplashDIContainer()
        let coordinator = SplashCoordinator(
            appCoordinator: self, splashDIContainer: container
        )
        return coordinator.showSplashView()
    }

    func createRepositoriesList() -> RepositoriesListView {
        let container = diContainer.makeRepositoryListDIContainer()
        let coordinator = RepositoriesListCoordinator(
            appCoordinator: self, diContainer: container
        )
        return coordinator.createRepositoriesListView()
    }

    func createRepositoryDetail(repository: Repository) -> RepositoryDetailView {
        let container = diContainer.makeRepositoriesDetailDIContainer()
        let coordinator = RepositoryDetailCoordinator(diContainer: container)
        return coordinator.createRepositoryDetail(repository: repository)
    }
}

extension AppCoordinator: Coordinator {
    func push(_ path: AppRoute) {
        DispatchQueue.main.async { [weak self] in
            self?.path.append(path)
        }
    }
    
    public func pop() {
        DispatchQueue.main.async { [weak self] in
            self?.path.removeLast()
        }
    }
}
