//
//  GithubRepositoryTests.swift
//  GithubRepositoryTests
//
//  Created by Ahmad Ismail on 04/08/2025.
//

@testable import GithubRepository
import Combine
import XCTest

final class GithubRepositoryTests: XCTestCase {

    func testExample() throws {
        // Write a regular XCTest
        XCTAssertTrue(true)
    }
}

final class RepositoriesListViewModelTests: XCTestCase {
    private var viewModel: RepositoriesListViewModel!
    private var mockUseCase: MockSearchRepositoriesUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockSearchRepositoriesUseCase()
        viewModel = RepositoriesListViewModel(
            searchUseCase: mockUseCase,
            closures: RepositoriesListViewModelClosures(didSelect: { repo in
            
            })
        )
        cancellables = []
    }

    func testSearchDebounceAndResults() {
        let expectation = XCTestExpectation(description: "Wait for search results")
        
        mockUseCase.mockResult = .success(
            SearchResponse(
                totalCount: 1,
                items: [Repository.mock(name: "GoogleAuthenticator")]
            )
        )

        viewModel.$repositories
            .dropFirst()
            .sink { repos in
                XCTAssertEqual(repos.count, 1)
                XCTAssertEqual(repos.first?.name, "GoogleAuthenticator")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchQuery = "Google" // 🔄 Match case with expected mock

        wait(for: [expectation], timeout: 2.0)
    }


    func testSearchFailureEmitsError() {
        let expectation = XCTestExpectation(description: "Wait for error state")
        
        mockUseCase.mockResult = .failure(NetworkError.serverError)

        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertEqual(message, NetworkError.serverError.localizedDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.searchQuery = "Google"
        wait(for: [expectation], timeout: 3.0)
    }
}

final class MockSearchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol {
    
    var mockResult: Result<SearchResponse, Error> = .success(SearchResponse(totalCount: 0, items: []))

    func execute(query: String, page: Int) -> AnyPublisher<SearchResponse, Error> {
        return mockResult.publisher.eraseToAnyPublisher()
    }
}
