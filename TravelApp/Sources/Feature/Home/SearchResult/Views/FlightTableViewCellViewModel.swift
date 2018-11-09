//
//  FlightTableViewCellViewModel.swift
//  TravelApp
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

class FlightTableViewCellViewModel {
    
    //MARK: - Properties
    
    let farePrice: String
    let airlineText: String
    let flightCodeText: String
    let departureTimeFlightText: String
    let departureAirportText: String
    let dateText: String
    let durationText: String
    let arrivalTimeFlightText: String
    let arrivalAirportText: String
    let stopOverText: String
    var returnFlightCellViewModelList: [FlightTableViewCellViewModel]?
    var onwardFlightCellViewModelList: [FlightTableViewCellViewModel]?
    
    //MARK: - Initializer Methods
    
    init(_ flight: Flight) {
        self.farePrice = "\(Localizable.searchResultBuy.localize()) \(flight.adultTotalFare?.toCurrency() ?? "-")" 
        self.airlineText = String(flight.airline?.split(separator: " ").first?.uppercased() ?? "-")
        self.flightCodeText = flight.flightCode?.uppercased() ?? "-"
        self.departureTimeFlightText = flight.departureTimeDate?.toString(format: .HHmm) ?? "-"
        self.departureAirportText = flight.origin?.uppercased() ?? "-"
        self.dateText = flight.departureTimeDate?.toString(format: .EEddofMM) ?? "-"
        self.durationText = flight.durationText?.uppercased() ?? "-"
        self.arrivalTimeFlightText = flight.arrivalTimeDate?.toString(format: .HHmm) ?? "-"
        self.arrivalAirportText = flight.destination?.uppercased() ?? "-"
        
        if let onwardflights = flight.onwardflights, onwardflights.count > 0 {
            self.stopOverText = "\(String(onwardflights.count)) \(Localizable.searchResultStopOver.localize())"
        } else {
            self.stopOverText = Localizable.searchResultDirectFlight.localize().uppercased()
        }        
        self.returnFlightCellViewModelList = self.createFlightList(flight.returnFlight)
        self.onwardFlightCellViewModelList = self.createFlightList(flight.onwardflights)
    }
    
    //MARK: - Private Methods
    private func createFlightList(_ flights: [Flight]?) -> [FlightTableViewCellViewModel]? {
        guard let flights = flights else { return nil }
        var flightsViewModelList: [FlightTableViewCellViewModel] = []
        for flight in flights {
            let viewModel = FlightTableViewCellViewModel(flight)
            flightsViewModelList.append(viewModel)
        }
        return flightsViewModelList
    }
}

