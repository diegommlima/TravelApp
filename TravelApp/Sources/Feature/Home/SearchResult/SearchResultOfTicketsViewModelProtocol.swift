//
//  SearchResultOfTicketsViewModelProtocol.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

protocol SearchResultOfTicketsViewModelProtocol {
    
    //MARK: - Properties
    
    var searchResultViewEvent: Dynamic<SearchResultViewEvent> { get set }
    var flightViewModelViewModelList: [FlightTableViewCellViewModel] { get set }

    //MARK: - Public Methods

    func loadTravels(withSearchModel searchModel: HomeSearchFormModel?)
    func filterByAirline(_ airline: String)
    func resetFilter()
    func order(by order: OrderFlights)
    func airlineList() -> [String]
}
