//
//  SearchResultUITests.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

class SearchResultUITests: BaseXCTestCase {
    
    // MARK: - Tests
    
    func testBottomButtons() {
        dynamicStubs.setupStub(url: "/api/search/", fileName: "SearchFlightSuccess")
        loadInitialState()

        let filterButton = SearchResultSteps.filterButton()
        let orderButton = SearchResultSteps.orderButton()

        verifySnapshotView(delay: 4)
        
        XCTAssert(filterButton.exists)
        XCTAssert(orderButton.exists)
    }
    
    private func loadInitialState() {
        
        HomeSearchUITests.skipHome(app)
        SearchResultSteps.waitScreen(testCase: self)
    }
}
