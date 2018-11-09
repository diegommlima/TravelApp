//
//  LocalizableStrings.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum Localizable: String {
    
    case navBackAccessibilityLabel
    
    case homeSearchIATAOrigin
    case homeSearchIATADestination
    case homeSearchDateOfTheTrip
    case homeSearchLapDate
    case homeSearchNumberOfPassengers
    case homeSearchSearchTicket
    case homeSearchRequiredFieldErrorMessage
    case homeSearchInvalidIATACodeErrorMessage
    case homeSearchInvalidDateFormatErrorMessage
    case homeSearchInvalidNumberOfPassengersErrorMessage
    
    case searchResultTitle
    case searchResultAirline
    case searchResultDepart
    case searchResultDuration
    case searchResultArrival
    case searchResultFilter
    case searchResultOrder
    case searchResultBuy
    case searchResultGoing
    case searchResultBack
    case searchResultDirectFlight
    case searchResultEmptyStateMessage
    case searchResultStopOver
    
    func localize() -> String {
        return self.rawValue.localize()
    }
}

