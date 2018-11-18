//
//  BaseXCTestCase.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest
@testable import TravelApp
import FBSnapshotTestCase

class BaseXCTestCase: FBSnapshotTestCase {
    // MARK: - Constants
    
    let app = XCUIApplication()
    let dynamicStubs = HTTPDynamicStubs()

    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        dynamicStubs.setUp()

        XCUIDevice.shared.orientation = .portrait
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // Get this argument on AppDelegate didFinishLaunchWithArguments to erease stored data. It will allow us to test as first user in each test in iOS 9 and 10.
        app.launchEnvironment = ["BASEURL" : "http://localhost:8080"]
        app.launchArguments = ["START_FROM_CLEAN_STATE"]
        app.launch()
//        recordMode = true;
    }
    
    override func tearDown() {
        super.tearDown()
        dynamicStubs.tearDown()
    }
    
    func verifySnapshotView(delay: TimeInterval = 0, removeStatusBarTime: Bool = true, tolerance: CGFloat = 0, identifier: String = "", file: StaticString = #file, line: UInt = #line) {
        if delay != 0 {
            wait(for: delay)
        }
        var image: UIImage? = app.screenshot().image
        if removeStatusBarTime {
            image = image?.removingStatusBarTime
        }
        FBSnapshotVerifyView(UIImageView(image: image), identifier: identifier, tolerance: tolerance, file: file, line: line)
    }
}
