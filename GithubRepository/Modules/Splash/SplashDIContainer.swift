//
//  SplashDIContainer.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI

final class SplashDIContainer: AppDIContainer {
    func makeSplashViewModel(
        closures: SplashViewModelClosures?
    ) -> SplashViewModel {
        return SplashViewModel(closures: closures)
    }

    func makeSplashView(
        closures: SplashViewModelClosures?
    ) -> SplashView {
        return SplashView(
            viewModel: self.makeSplashViewModel(
                closures: closures
            )
        )
    }
}
