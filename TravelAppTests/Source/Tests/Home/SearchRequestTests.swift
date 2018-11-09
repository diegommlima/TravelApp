//
//  SearchRequestTests.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import XCTest
@testable import TravelApp

class SearchRequestTests: XCTestCase {
    
    func testFetchFlightsWithSucess() {
        let requestModel = TravelRequest(originIATACode: "a", destinationIATACode: "b", departureDate: Date(), arrivalDate: Date(), numberOfTickets: 1)
        let mockProvider = NetworkMockProvider(mockType: .json(fileName: "SearchFlightSuccess"), returnStatusCode: 200)
        let request = SearchRequest(withProvider: mockProvider)
        
        let expectationCallback = XCTestExpectation(description: "Callback needs to be called")
        expectationCallback.assertForOverFulfill = true
        
        request.fetchFlights(withModelRequest: requestModel) { (result) in
            expectationCallback.fulfill()
            do {
                guard let items = try result() else {
                    XCTFail("Fail to unwrap suggested items")
                    return
                }
                XCTAssertTrue(items.count == 299, "Wrong Flights count.")
                let flight = items.first
                XCTAssertEqual(flight?.origin, "CNF")
                XCTAssertEqual(flight?.destination, "GRU")
                XCTAssertEqual(flight?.airline, "Avianca Brazil")
                XCTAssertEqual(flight?.flightCode, "6145")
                XCTAssertEqual(flight?.durationText, "5h 0m")
                //TODO: Validar o restante dos parametros...
            } catch {
                XCTFail("Fail to retrieve content. Caught error \"\(error)\"")
            }
        }
        wait(for: [expectationCallback], timeout: 1)
    }
    
    func testFetchFlightsWithNoData() {
        let requestModel = TravelRequest(originIATACode: "a", destinationIATACode: "b", departureDate: Date(), arrivalDate: Date(), numberOfTickets: 1)
        let mockProvider = NetworkMockProvider(mockType: .json(fileName: "invalidName"), returnStatusCode: 200)
        let request = SearchRequest(withProvider: mockProvider)
        
        let expectationCallback = XCTestExpectation(description: "Callback needs to be called")
        expectationCallback.assertForOverFulfill = true
        
        request.fetchFlights(withModelRequest: requestModel) { (result) in
            do {
                guard (try result()) != nil else {
                    XCTFail("Fail to unwrap suggested items")
                    return
                }
                XCTFail("Should not be able to retrive item")
            } catch TechnicalError.unableToRetrieveData {
                expectationCallback.fulfill()
            } catch {
                XCTFail("Fail to retrieve content. Caught error \"\(error)\"")
            }
        }
        wait(for: [expectationCallback], timeout: 1)
    }
}
