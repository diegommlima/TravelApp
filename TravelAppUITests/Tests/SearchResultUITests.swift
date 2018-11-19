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
        dynamicStubs.setupStub(url: "/api/search", fileName: "SearchFlightSuccess", delay: 1)
        loadInitialState()

        verifySnapshotView(identifier: "loading")

        let filterButton = SearchResultSteps.filterButton()
        let orderButton = SearchResultSteps.orderButton()

        verifySnapshotView(delay: 2, identifier: "loaded")
        
        XCTAssert(filterButton.exists)
        XCTAssert(orderButton.exists)
    }
    
    func testErrorView() {
        loadInitialState()
        
        verifySnapshotView(identifier: "error")
        //It seems that there is an error where XCUITest does not recognize a UITableView.BackgroundView
        //https://forums.developer.apple.com/message/253566#253566
    }
    
    private func loadInitialState() {
        HomeSearchUITests.skipHome(app)
        SearchResultSteps.waitScreen(testCase: self)
    }
}
