//
//  RepositoriesListViewModel.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import Foundation
import Combine
import SwiftUI

public struct RepositoriesListViewModelClosures {
    let didSelect: (Repository) -> Void
}

final class RepositoriesListViewModel: ObservableObject {
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case error(String)
        case noResults
    }
    
    @Published private(set) var state: State = .idle
    @Published var repositories: [Repository] = []
    @Published var searchQuery: String = "google"
    @Published var error: Error?

    private var totalCount: Int = 0
    private var page = 1
    private var isFetching = false
    private let searchUseCase: SearchRepositoriesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var closures: RepositoriesListViewModelClosures?

    init(searchUseCase: SearchRepositoriesUseCaseProtocol,
         closures: RepositoriesListViewModelClosures?) {
        self.searchUseCase = searchUseCase
        self.closures = closures
        setupSearchDebounce()
        Task { await performSearch(query: searchQuery, page: page) }
    }

    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                self.resetAndSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    func refresh() {
        ImageCache.shared.removeAll()
        CacheManager.shared.clear()
        resetAndSearch(query: searchQuery)
    }

    func resetAndSearch(query: String) {
        guard !isFetching else { return }
        
        self.state = .loading
        self.repositories = []
        self.page = 1
        
        Task { await performSearch(query: query, page: self.page) }
    }
    
    func loadNextPage() {
        guard !isFetching,
              state != .loading,
              repositories.count < totalCount else {
            return
        }
        isFetching = true
        page += 1
        
        Task { await performSearch(query: searchQuery, page: page) }
    }

    @MainActor
    private func performSearch(query: String, page: Int) {
        if page == 1, let cached = CacheManager.shared.get(query: query) {
            self.repositories = cached.items
            self.totalCount = cached.totalCount
            self.state = .loaded
            return
        }
        searchUseCase.execute(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isFetching = false
                if case .failure(let error) = completion {
                    self?.repositories = []
                    self?.error = error
                    self?.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.totalCount = response.totalCount
                if page == 1 {
                    self.repositories = response.items
                    CacheManager.shared.set(query: query, response: response)
                } else {
                    self.repositories.append(contentsOf: response.items)
                }
                self.state = self.repositories.isEmpty ? .noResults : .loaded
            }
            .store(in: &cancellables)
    }

    func didSelect(repository: Repository) {
        closures?.didSelect(repository)
    }
}

