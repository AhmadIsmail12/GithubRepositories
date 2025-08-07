//
//  GitHubRepositoryApp.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI

@main
struct GitHubRepositoryApp: App {
    @StateObject var appCoordinator = AppCoordinator(diContainer: AppDIContainer())

    var body: some Scene {
        WindowGroup {
            if appCoordinator.isShowingSplash {
                appCoordinator.start()
            } else {
                NavigationStack(path: $appCoordinator.path) {
                    appCoordinator.createRepositoriesList()
                    .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .repositoryDetail(let repo):
                                appCoordinator.createRepositoryDetail(repository: repo)
                            }
                        }
                }
            }
        }
    }
}
