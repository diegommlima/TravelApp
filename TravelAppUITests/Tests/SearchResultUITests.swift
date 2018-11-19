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
        //http://developer.goibibo.com/api/search?format=json&counter=100&app_key=fadc0a120521b900ba893016c766c83f&app_id=04b76e21&seatingclass=E&destination=RVD&dateofarrival=20181216&dateofdeparture=20181210&children=0&source=GYN&infants=0&adults=1
        
        let httpStub = HTTPStubInfo(url: "/api/search", jsonFileName: "SearchFlightSuccess", delay: 1)
        HTTPDynamicStubs.shared.setupStub(models: [httpStub])
        loadInitialState()

        verifySnapshotView(tolerance: 0.001, identifier: "loading")

        let filterButton = SearchResultSteps.filterButton()
        let orderButton = SearchResultSteps.orderButton()

        verifySnapshotView(delay: 2, identifier: "loaded")
        
        XCTAssert(filterButton.exists)
        XCTAssert(orderButton.exists)
    }
    
    func testErrorView() {
        loadInitialState()
        
        verifySnapshotView(delay: 1, identifier: "error")
        //It seems that there is an error where XCUITest does not recognize a UITableView.BackgroundView
        //https://forums.developer.apple.com/message/253566#253566
    }
    
    private func loadInitialState() {
        HomeSearchUITests.skipHome(app)
        SearchResultSteps.waitScreen(testCase: self)
    }
}
