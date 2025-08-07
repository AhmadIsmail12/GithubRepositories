//
//  RepositoryDetailView.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI

struct RepositoryDetailView: View {
    @StateObject var viewModel: RepositoryDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 20) {
                    CachedAsyncImage(
                        url: viewModel.repository.owner.avatarURL,
                        placeholder: Image(systemName: "photo.fill")
                    )
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.repository.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .accessibilityIdentifier("RepositoryDetailTitle")
                        Text("by \(viewModel.repository.owner.login)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    DetailRow(icon: "star.fill", title: "Stargazers", value: "\(viewModel.repository.stargazersCount)")
                    // Fix is here: explicitly reference DateFormatter
                    DetailRow(icon: "calendar", title: "Created At", value: "\(viewModel.repository.createdAt.formatted())")
                    DetailRow(icon: "link", title: "URL", value: viewModel.repository.htmlURL.absoluteString)
                        .onTapGesture {
                            if let url = URL(string: viewModel.repository.htmlURL.absoluteString) {
                                UIApplication.shared.open(url)
                            }
                        }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Repo Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 30)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(value)
                    .font(.body)
            }
        }
    }
}
