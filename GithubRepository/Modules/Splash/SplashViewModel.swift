//
//  SplashViewModel.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation

public struct SplashViewModelClosures {
    let splashDidFinish: () -> Void
}

final class SplashViewModel: ObservableObject {
    var closures: SplashViewModelClosures?

    init(closures: SplashViewModelClosures?) {
        self.closures = closures
    }
    
    func didFinishSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.closures?.splashDidFinish()
        }
    }
}
