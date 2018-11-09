//
//  UIStepsProtocol.swift
//  TravelAppUITests
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

protocol UIStepsProtocol {
    /// Wait screen be avaible for test
    ///
    /// - Parameter testCase: Current screen testCase instance
    static func waitScreen(testCase: XCTestCase)
}

extension UIStepsProtocol {
    
    // MARK: - Common steps
    
    /// Type text value in a TextField
    ///
    /// - Parameters:
    ///   - identifier: element identifier
    ///   - value: value to by type
    static func fillInTextField(identifier: String, value: String) {
        let textField = XCUIApplication().textFields[identifier]
        textField.tap()
        textField.typeText(value)
    }
    
    static func compareTextField(identifier: String, value: String) -> Bool {
        let textField = XCUIApplication().textFields[identifier]
        guard let currentText = textField.value as? String else {
            XCTFail("Unable to get current text")
            
            return false
        }
        
        return currentText == value
    }
    
    /// Type text value in a secure TextField
    ///
    /// - Parameters:
    ///   - identifier: element identifier
    ///   - value: value to by type
    static func fillInSecureTextField(identifier: String, value: String) {
        let textField = XCUIApplication().secureTextFields[identifier]
        textField.tap()
        textField.typeText(value)
    }
    
    /// Tap button
    ///
    /// - Parameter identifier: button identifier
    static func tapButton(identifier: String) {
        XCUIApplication().buttons[identifier].tap()
    }
    
    /// Tap tab bar button
    ///
    /// - Parameter identifier: tab bar button identifier
    static func tapTabBarButton(identifier: String) {
        XCUIApplication().tabBars.buttons[identifier].tap()
    }
    
    /// Check if Navigation Title element exists
    ///
    /// - Parameter title: navigation title string
    static func navigationElement(title: String) -> XCUIElement {
        if #available(iOS 11, *) {
            return XCUIApplication().navigationBars[title]
        } else {
            return XCUIApplication().staticTexts[title]
        }
    }
}
