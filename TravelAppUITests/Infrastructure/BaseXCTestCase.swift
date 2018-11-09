//
//  BaseXCTestCase.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest
@testable import TravelApp

class BaseXCTestCase: XCTestCase {
    // MARK: - Constants
    
    let app = XCUIApplication()
    
    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        
        XCUIDevice.shared.orientation = .portrait
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // Get this argument on AppDelegate didFinishLaunchWithArguments to erease stored data. It will allow us to test as first user in each test in iOS 9 and 10.
        app.launchArguments = ["START_FROM_CLEAN_STATE"]
        app.launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
}
