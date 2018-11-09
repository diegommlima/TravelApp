//
//  TravelResponse.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

struct TravelResponse {
    let travels: [Flight]?
    private enum CodingKeys: String, CodingKey {
        case data
        case onwardflights
    }
}

extension TravelResponse: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        travels = try data.decodeIfPresent([Flight].self, forKey: .onwardflights)
    }
}

struct Flight {
    
    let origin: String?
    let destination: String?
    let airline: String?
    let flightCode: String?
    let durationText: String?
    let departureTimeDate: Date?
    let arrivalTimeDate: Date?
    let adultTotalFare: Double?
    let returnFlight: [Flight]?
    let onwardflights: [Flight]?
    
    private enum CodingKeys: String, CodingKey {
        case origin
        case destination
        case airline
        case flightcode
        case duration
        case depdate
        case arrdate
        case fare
        case adulttotalfare
        case returnfl
        case onwardflights
    }
}

extension Flight: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        destination = try values.decodeIfPresent(String.self, forKey: .destination)
        airline = try values.decodeIfPresent(String.self, forKey: .airline)
        flightCode = try values.decodeIfPresent(String.self, forKey: .flightcode)
        durationText = try values.decodeIfPresent(String.self, forKey: .duration)
        let departureTimeString = try values.decode(String.self, forKey: .depdate)
        let arrivalTimeString = try values.decode(String.self, forKey: .arrdate)
        departureTimeDate = departureTimeString.toDate(format: .yyyyMMddtHHmm)
        arrivalTimeDate = arrivalTimeString.toDate(format: .yyyyMMddtHHmm)
        returnFlight = try values.decodeIfPresent([Flight].self, forKey: .returnfl)
        onwardflights = try values.decodeIfPresent([Flight].self, forKey: .onwardflights)

        let fare = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .fare)
        adultTotalFare = try fare.decodeIfPresent(Double.self, forKey: .adulttotalfare)
    }
}
