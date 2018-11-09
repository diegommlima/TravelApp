//
//  TravelRequest.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

struct TravelRequest {
    private let appID = GoibiboApiProvider.appID
    private let appKey = GoibiboApiProvider.appKey
    private let format = "json"
    private let seatingclass = "E"
    private let children = 0
    private let infants = 0
    private let counter = 100
    
    let originIATACode: String
    let destinationIATACode: String
    let departureDate: Date
    let arrivalDate: Date
    let numberOfTickets: Int
    
    private enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case appKey = "app_key"
        case format = "format"
        case seatingclass = "seatingclass"
        case children = "children"
        case infants = "infants"
        case counter = "counter"
        case originIATACode = "source"
        case destinationIATACode = "destination"
        case departureDate = "dateofdeparture"
        case arrivalDate = "dateofarrival"
        case numberOfTickets = "adults"
    }
}

extension TravelRequest: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let departureDateString = departureDate.toString(format: .yyyyMMdd)
        let arrivalDateString = arrivalDate.toString(format: .yyyyMMdd)
        
        try container.encode(appID, forKey: .appID)
        try container.encode(appKey, forKey: .appKey)
        try container.encode(format, forKey: .format)
        try container.encode(seatingclass, forKey: .seatingclass)
        try container.encode(children, forKey: .children)
        try container.encode(infants, forKey: .infants)
        try container.encode(counter, forKey: .counter)
        try container.encode(originIATACode.uppercased(), forKey: .originIATACode)
        try container.encode(destinationIATACode.uppercased(), forKey: .destinationIATACode)
        try container.encode(departureDateString, forKey: .departureDate)
        try container.encode(arrivalDateString, forKey: .arrivalDate)
        try container.encode(numberOfTickets, forKey: .numberOfTickets)
    }
}
