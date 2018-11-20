//
//  HomeSearchUITests.swift
//  TravelAppUITests
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

class HomeSearchUITests: BaseXCTestCase {
        
    // MARK: - Overrides
    
    override func setUp() {
        super.setUp()
        HomeSearchSteps.waitScreen(testCase: self)
    }
    
    // MARK: - Tests
    
    func testFillFormWithSuccess() {
                
        let originTextField = HomeSearchSteps.originTextField()
        let destinationTextField = HomeSearchSteps.destinationTextField()
        let dateOfTheTripTextField = HomeSearchSteps.dateOfTheTripTextField()
        let lapDateTextField = HomeSearchSteps.lapDateTextField()
        let numberOFPassengersTextField = HomeSearchSteps.numberOFPassengersTextField()
        let searchTicketButton = HomeSearchSteps.searchTicketButton()
        
        verifySnapshotView(identifier: "before")

        originTextField.tap()
        originTextField.typeText("gyn")
        
        destinationTextField.tap()
        destinationTextField.typeText("rvd")
        
        dateOfTheTripTextField.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "20")
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "dezembro")
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        XCTAssertEqual("20/12/2018", dateOfTheTripTextField.value as! String)
        
        lapDateTextField.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "25")
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "dezembro")
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        XCTAssertEqual("25/12/2018", lapDateTextField.value as! String)

        numberOFPassengersTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "2")
        
        let button = app.buttons["ToolbarDoneButton"]
        button.tap()
        
        verifySnapshotView(delay: 0.5)

        searchTicketButton.tap()
        let label = app.navigationBars["PESQUISAR PASSAGEM"]
        XCTAssert(label.exists)
    }
    
    static func skipHome(_ app: XCUIApplication) {
        let originTextField = HomeSearchSteps.originTextField()
        let destinationTextField = HomeSearchSteps.destinationTextField()
        let dateOfTheTripTextField = HomeSearchSteps.dateOfTheTripTextField()
        let lapDateTextField = HomeSearchSteps.lapDateTextField()
        let numberOFPassengersTextField = HomeSearchSteps.numberOFPassengersTextField()
        let searchTicketButton = HomeSearchSteps.searchTicketButton()
        
        originTextField.tap()
        originTextField.typeText("gyn")
        
        destinationTextField.tap()
        destinationTextField.typeText("rvd")
        
        dateOfTheTripTextField.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "20")
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "dezembro")
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        
        lapDateTextField.tap()
        app.datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "25")
        app.datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "dezembro")
        app.datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        
        numberOFPassengersTextField.tap()
        app.pickerWheels.element.adjust(toPickerWheelValue: "2")
        
        let button = app.buttons["ToolbarDoneButton"]
        button.tap()
        
        searchTicketButton.tap()
    }
}

