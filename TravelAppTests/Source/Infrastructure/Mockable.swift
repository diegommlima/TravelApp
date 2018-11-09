//
//  Mockable.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum MockType {
    case json(fileName: String)
    case error(type: Error)
    case validWithObj(anyObj: Any)
    case jsonWithStatusCode(statusCode: Int, fileName: String)
    case valid
    case invalid
    case empty
}

protocol Mockable {
    var mockType: MockType { get }
    init(mockType: MockType)
}
