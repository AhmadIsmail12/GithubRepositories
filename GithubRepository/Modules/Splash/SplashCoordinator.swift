//
//  SplashCoordinator.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

final class SplashCoordinator {
    var splashDIContainer: SplashDIContainer
    private var appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator, splashDIContainer: SplashDIContainer) {
        self.appCoordinator = appCoordinator
        self.splashDIContainer = splashDIContainer
    }

    func showSplashView() -> SplashView {
        let view = splashDIContainer.makeSplashView(
            closures: SplashViewModelClosures(
                splashDidFinish: splashDidFinish
            )
        )
        return view
    }
    
    func splashDidFinish() {
        self.appCoordinator.isShowingSplash = false
    }
}
