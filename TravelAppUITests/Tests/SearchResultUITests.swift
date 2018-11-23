//
//  SearchResultUITests.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest
import Swifter

class SearchResultUITests: BaseXCTestCase {
    
    // MARK: - Tests
    
    func testBottomButtons() {
        
        let httpStub = HTTPStubInfo(url: "/api/search", jsonFileName: "SearchFlightSuccess", delay: 1)
        HTTPDynamicStubs.shared.setupStub(httpStub)
        
        loadInitialState()

        verifySnapshotView(tolerance: 0.001, identifier: "loading")
        verifySnapshotView(delay: 1.5, identifier: "loaded")
    }
    
    func testErrorView() {
        
        let httpStub = HTTPStubInfo(url: "/api/search")
        HTTPDynamicStubs.shared.setupStub(httpStub, httpRespose: HttpResponse.internalServerError)
        
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
