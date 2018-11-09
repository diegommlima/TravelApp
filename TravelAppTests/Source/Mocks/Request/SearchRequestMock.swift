//
//  SearchRequestMock.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation
@testable import TravelApp

class SearchRequestMock: SearchRequestProtocol, Mockable {
    
    var mockType: MockType

    required init(mockType: MockType) {
        self.mockType = mockType
    }
    
    func fetchFlights(withModelRequest requestModel: TravelRequest, completion: @escaping SearchFlightCallback) {
        switch mockType {
        case .empty:
            completion { [] }
        case .invalid:
            completion { nil }
        case .validWithObj(let obj):
            completion { obj as? [Flight] }
        default:
            fatalError("MockType needs to be handled")
        }
    }
}
