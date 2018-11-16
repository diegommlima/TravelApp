//
//  XCTestCase.swift
//  TravelAppUITests
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

// MARK: - XCTestCase extension

extension XCTestCase {
    
    /// Wait an element exists to start interact with it.
    ///
    /// - Parameters:
    ///   - element: Current element
    ///   - timeout: Optional timeout. Default value is 10 seconds.
    func waitElementExists(element: XCUIElement, timeout: TimeInterval = 10) {
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout) { (error) in
            guard let unwrappedError = error else { return }
            
            XCTFail("Wait Element Fail: \(unwrappedError.localizedDescription)")
        }
    }
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}

