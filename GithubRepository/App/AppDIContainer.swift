//
//  AppDIContainer.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation
import SwiftUI

public class AppDIContainer {
    
    // MARK: - Networking
    private lazy var networkService: NetworkServiceProtocol = {
        return NetworkService()
    }()
    
    // MARK: - Data Layer
    private lazy var repositoriesListRepository: RepositoriesListRepositoryProtocol = {
        return RepositoriesListRepository(networkService: networkService)
    }()
    
    // MARK: - Use Case Layer
    lazy var searchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol = {
        return SearchRepositoriesUseCase(repository: repositoriesListRepository)
    }()

    func makeSplashDIContainer() -> SplashDIContainer {
        return SplashDIContainer()
    }
    
    func makeRepositoryListDIContainer() -> RepositoriesListDIContainer {
        return RepositoriesListDIContainer()
    }
    
    func makeRepositoriesDetailDIContainer() -> RepositorDetailDIContainer {
        return RepositorDetailDIContainer()
    }
}
