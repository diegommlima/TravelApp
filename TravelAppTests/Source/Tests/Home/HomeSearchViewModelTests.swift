//
//  HomeSearchViewModelTests.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest

@testable import TravelApp

class HomeSearchViewModelTests: XCTestCase {
    
    //TODO: Incrementar cenários de teste.
    
    //MARK: - Public Methods

    func testValidateFormWithSuccess() {
        let formModel = HomeSearchFormModel(originText: "asd", destinationText: "fgh", dateOfTheTripText: "10/12/2018", lapDateText: "12/12/2018", numberOfPassengers: "1")
        let expectationSuccess = XCTestExpectation(description: "Success needs to be called")
        expectationSuccess.assertForOverFulfill = true
        let viewModel = HomeSearchViewModel()
        viewModel.searchFormState.bind { (searchFormState) in
            guard let searchFormState = searchFormState else { return }
            switch searchFormState {
            case .success(let obj):
                XCTAssertEqual(obj, formModel)
                expectationSuccess.fulfill()
            default:
                XCTFail("Errors can't be called")
            }
        }
        
        viewModel.validateForm(withForm: formModel)
        wait(for: [expectationSuccess], timeout: 1)
    }
    
    func testValidateFormWithIATAError() {
        let formModel = HomeSearchFormModel(originText: "as", destinationText: "fgh", dateOfTheTripText: "10/12/2018", lapDateText: "12/12/2018", numberOfPassengers: "1")
        let expectationIATAOrigin = XCTestExpectation(description: "IATA Origin Error needs to be called")
        expectationIATAOrigin.assertForOverFulfill = true
        let viewModel = HomeSearchViewModel()
        viewModel.searchFormState.bind { (searchFormState) in
            guard let searchFormState = searchFormState else { return }
            switch searchFormState {
            case .iataOriginError(let errorMessage):
                XCTAssertEqual(errorMessage, "código IATA inválido")
                expectationIATAOrigin.fulfill()
            default:
                XCTFail("Errors can't be called")
            }
        }
        
        viewModel.validateForm(withForm: formModel)
        wait(for: [expectationIATAOrigin], timeout: 1)
    }
    
    func testValidateFormNumberOfPassengersError() {
        let formModel = HomeSearchFormModel(originText: "asd", destinationText: "fgh", dateOfTheTripText: "10/12/2018", lapDateText: "12/12/2018", numberOfPassengers: "0")
        let expectationNumberOfPassengers = XCTestExpectation(description: "numberOfPassengers Error needs to be called")
        expectationNumberOfPassengers.assertForOverFulfill = true
        let viewModel = HomeSearchViewModel()
        viewModel.searchFormState.bind { (searchFormState) in
            guard let searchFormState = searchFormState else { return }
            switch searchFormState {
            case .numberOfPassengersError(let errorMessage):
                XCTAssertEqual(errorMessage, "número de passageiros deve ser entre 1-9")
                expectationNumberOfPassengers.fulfill()
            default:
                XCTFail("Errors can't be called")
            }
        }
        
        viewModel.validateForm(withForm: formModel)
        wait(for: [expectationNumberOfPassengers], timeout: 1)
    }
    
    func testValidateFormWithEmptyFields() {
        
        let formModel = HomeSearchFormModel(originText: nil, destinationText: nil, dateOfTheTripText: nil, lapDateText: nil, numberOfPassengers: nil)
        
        let expectationIATAOrigin = XCTestExpectation(description: "IATA Origin Error needs to be called")
        expectationIATAOrigin.assertForOverFulfill = true
        let expectationIATADestination = XCTestExpectation(description: "IATA Destination Error needs to be called")
        expectationIATADestination.assertForOverFulfill = true
        let expectationDateOfTheTrip = XCTestExpectation(description: "DateOfTheTrip Error needs to be called")
        expectationDateOfTheTrip.assertForOverFulfill = true
        let expectationLapDate = XCTestExpectation(description: "lapDate Error needs to be called")
        expectationLapDate.assertForOverFulfill = true
        let expectationNumberOfPassengers = XCTestExpectation(description: "numberOfPassengers Error needs to be called")
        expectationNumberOfPassengers.assertForOverFulfill = true
        
        let viewModel = HomeSearchViewModel()
        viewModel.searchFormState.bind { (searchFormState) in
            guard let searchFormState = searchFormState else { return }
            
            switch searchFormState {
            case .success(_):
                XCTFail("success can't be called")
            case .iataOriginError(let errorMessage):
                XCTAssertEqual(errorMessage, "campo obrigatório")
                expectationIATAOrigin.fulfill()
            case .iataDestinationError(let errorMessage):
                XCTAssertEqual(errorMessage, "campo obrigatório")
                expectationIATADestination.fulfill()
            case .dateOfTheTripError(let errorMessage):
                XCTAssertEqual(errorMessage, "campo obrigatório")
                expectationDateOfTheTrip.fulfill()
            case .lapDateError(let errorMessage):
                XCTAssertEqual(errorMessage, "campo obrigatório")
                expectationLapDate.fulfill()
            case .numberOfPassengersError(let errorMessage):
                XCTAssertEqual(errorMessage, "campo obrigatório")
                expectationNumberOfPassengers.fulfill()
            }
        }
        
        viewModel.validateForm(withForm: formModel)
        wait(for: [expectationIATAOrigin, expectationIATADestination, expectationDateOfTheTrip, expectationLapDate, expectationNumberOfPassengers], timeout: 1)
    }
}
