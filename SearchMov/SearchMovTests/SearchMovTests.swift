//
//  SearchMovTests.swift
//  SearchMovTests
//
//  Created by Mathew Thomas on 25/10/2020.
//

import XCTest
@testable import SearchMov

class SearchMovTests: XCTestCase {
    
    private let networkManager = NetworkManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearch() {
        let prom = expectation(description: "Search for Star Wars")
        let movies =  networkManager.searchMovieByName(name: "Star Wars")
        let first = movies?[0]
        XCTAssertNotNil(movies)
        XCTAssertTrue(((first?.Title?.contains("Star Wars")) != nil))
        prom.fulfill()
        waitForExpectations(timeout: 2, handler: nil)
    }
}
