//
//  SearchResultSteps.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

class SearchResultSteps: UIStepsProtocol {
    
    // MARK: - UISteps Protocol
    
    static func waitScreen(testCase: XCTestCase) {
        let title = XCUIApplication().navigationBars["PESQUISAR PASSAGEM"]
        testCase.waitElementExists(element: title)
    }
    
    // MARK: - UI Elements
    
    static func filterButton() -> XCUIElement {
        let element = XCUIApplication().buttons["FILTRAR"]
        return element
    }
    
    static func orderButton() -> XCUIElement {
        let element = XCUIApplication().buttons["ORDENAR"]
        return element
    }
}
