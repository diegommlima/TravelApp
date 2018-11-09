//
//  SearchResultUITests.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

class SearchResultUITests: BaseXCTestCase {
    
    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        
        HomeSearchUITests.skipHome(app)
        SearchResultSteps.waitScreen(testCase: self)

    }
    
    // MARK: - Tests
    
    func testBottomButtons() {
        
        let filterButton = SearchResultSteps.filterButton()
        let orderButton = SearchResultSteps.orderButton()

        XCTAssert(filterButton.exists)
        XCTAssert(orderButton.exists)
    }
}
