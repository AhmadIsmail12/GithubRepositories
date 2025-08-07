//
//  GithubRepositoryUITests.swift
//  GithubRepositoryUITests
//
//  Created by Ahmad Ismail on 04/08/2025.
//

import XCTest
@testable import GithubRepository

final class GithubRepositoryUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    @MainActor
    func testSearchFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the search field to appear
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search field did not appear")
        searchField.tap()
        searchField.typeText("Test")
        print(app.debugDescription)
        // Access the List using `.otherElements`
        let listView = app.collectionViews["RepositoriesList"]
        XCTAssertTrue(listView.waitForExistence(timeout: 10), "Repository list container did not appear")

        // Look for cells inside it
        let firstCell = listView.descendants(matching: .cell).firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "Search result did not load")
        firstCell.tap()

        // Check for detail view
        let detailTitle = app.staticTexts["RepositoryDetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5), "Detail view did not appear")
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
