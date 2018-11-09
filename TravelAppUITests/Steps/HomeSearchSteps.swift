//
//  HomeSearchSteps.swift
//  TravelAppUITests
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

class HomeSearchSteps: UIStepsProtocol {
    
    // MARK: - UISteps Protocol
    
    static func waitScreen(testCase: XCTestCase) {
        let title = XCUIApplication().navigationBars["Home"]
        testCase.waitElementExists(element: title)
    }
    
    // MARK: - UI Elements
    
    static func originTextField() -> XCUIElement {
        let element = XCUIApplication().textFields["originTextField"]
        return element
    }
    
    static func destinationTextField() -> XCUIElement {
        let element = XCUIApplication().textFields["destinationTextField"]
        return element
    }
    
    static func dateOfTheTripTextField() -> XCUIElement {
        let element = XCUIApplication().textFields["dateOfTheTripTextField"]
        return element
    }
    
    static func lapDateTextField() -> XCUIElement {
        let element = XCUIApplication().textFields["lapDateTextField"]
        return element
    }
    
    static func numberOFPassengersTextField() -> XCUIElement {
        let element = XCUIApplication().textFields["numberOFPassengersTextField"]
        return element
    }
    static func searchTicketButton() -> XCUIElement {
        let element = XCUIApplication().buttons["searchTicketButton"]
        return element
    }
}
