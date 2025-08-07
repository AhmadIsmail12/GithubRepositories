//
//  SplashView.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("GitHub Repositories")
                .font(.largeTitle.bold())
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.didFinishSplash()
        }
    }
}
