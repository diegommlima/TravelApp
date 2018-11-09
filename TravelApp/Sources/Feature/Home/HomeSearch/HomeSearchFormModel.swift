//
//  HomeSearchFormModel.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

struct HomeSearchFormModel: Equatable {
    let originText: String?
    let destinationText: String?
    let dateOfTheTripText: String?
    let lapDateText: String?
    let numberOfPassengers: String?
    
    static func == (lhs: HomeSearchFormModel, rhs: HomeSearchFormModel) -> Bool {
        return lhs.originText == rhs.originText &&
        lhs.destinationText == rhs.destinationText &&
        lhs.dateOfTheTripText == rhs.dateOfTheTripText &&
        lhs.lapDateText == rhs.lapDateText &&
        lhs.numberOfPassengers == rhs.numberOfPassengers
    }
}
