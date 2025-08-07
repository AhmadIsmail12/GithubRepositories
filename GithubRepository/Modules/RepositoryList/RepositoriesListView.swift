//
//  RepositoriesListView.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import SwiftUI

struct RepositoriesListView: View {
    @StateObject var viewModel: RepositoriesListViewModel

    var body: some View {
        List {
            ForEach(viewModel.repositories) { repo in
                Button {
                    viewModel.didSelect(repository: repo)
                } label: {
                    RepositoryRow(repository: repo)
                }.accessibilityIdentifier("RepositoryCell_\(repo.id)")
            }

            
            if viewModel.state == .loading && viewModel.repositories.isEmpty {
               HStack {
                   Spacer()
                   ProgressView()
                   Spacer()
               }
           } else if viewModel.state == .loaded, !viewModel.repositories.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }.onAppear {
                    viewModel.loadNextPage()
                }
            }
        }
        .accessibilityIdentifier("RepositoriesList")
        .refreshable {
            viewModel.refresh()
        }
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("GitHub Repositories")
        .overlay {
            switch viewModel.state {
            case .idle:
                Text("Start searching for Google repositories.")
                    .font(.title3)
                    .padding()
            case .noResults:
                Text("No repositories found.")
                    .font(.title3)
                    .padding()
            case .error(let message):
                Text(message)
                    .font(.title3)
                    .padding()
            case .loading where !viewModel.repositories.isEmpty:
                EmptyView()
            default:
                EmptyView()
            }
        }
    }
}

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CachedAsyncImage(
                url: repository.owner.avatarURL,
                placeholder: Image(systemName: "photo.fill")
            )
            .frame(width: 50, height: 50)
            .cornerRadius(8)
            .scaledToFill()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .font(.headline)
                Text("Created: \(repository.createdAt, formatter: DateFormatter.shortDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
