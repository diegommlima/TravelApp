//
//  SearchResultOfTicketsViewModel.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum SearchResultViewEvent {
    case loading
    case fullError
    case fullEmptyState
    case loaded
}

enum OrderFlights {
    case standard
    case price
}

class SearchResultOfTicketsViewModel: SearchResultOfTicketsViewModelProtocol {
    
    // MARK: - Properties
    
    internal var searchResultViewEvent = Dynamic<SearchResultViewEvent>(.loading)
    internal var flightViewModelViewModelList: [FlightTableViewCellViewModel] = []

    private var searchRequest: SearchRequestProtocol
    private var flightList: [Flight]?

    // MARK: - Initializer Methods
    
    init(searchRequest: SearchRequestProtocol = SearchRequest(withProvider: nil)) {
        self.searchRequest = searchRequest
    }
    
    // MARK: - Public Methods
    
    func loadTravels(withSearchModel searchModel: HomeSearchFormModel?) {
        
        guard let travelRequest = travelRequest(bySearchFormModel: searchModel) else {
            searchResultViewEvent.value = .fullError
            return
        }
        searchResultViewEvent.value = .loading
        searchRequest.fetchFlights(withModelRequest: travelRequest) { [weak self] (result) in
            guard let weakSelf = self else { return }
            do {
                guard let flightList = try result() else {
                    throw BusinessError.invalidValue("invalid value")
                }
                weakSelf.flightList = flightList
                weakSelf.createViewModel(withNewFlights: flightList)
                if flightList.count > 0 {
                     weakSelf.searchResultViewEvent.value = .loaded
                } else {
                     weakSelf.searchResultViewEvent.value = .fullEmptyState
                }
            } catch {
                weakSelf.searchResultViewEvent.value = .fullError
            }
        }
    }
    
    func filterByAirline(_ airline: String) {
        flightViewModelViewModelList.removeAll()
        let filteredArray = self.flightList?.filter { $0.airline == airline } ?? []
        createViewModel(withNewFlights: filteredArray)
        searchResultViewEvent.value = .loaded
    }
    
    func resetFilter() {
        guard let flightList = self.flightList else {
            searchResultViewEvent.value = .fullError
            return
        }
        flightViewModelViewModelList.removeAll()
        createViewModel(withNewFlights: flightList)
        searchResultViewEvent.value = .loaded
    }
    
    func order(by order: OrderFlights) {
        guard let flightList = self.flightList else {
            searchResultViewEvent.value = .fullError
            return
        }
        
        flightViewModelViewModelList.removeAll()
        var tempArray = flightList
        if order == .price {
            tempArray = flightList.sorted(by: { $0.adultTotalFare ?? 0 < $1.adultTotalFare ?? 0 })
        }
        createViewModel(withNewFlights: tempArray)
        searchResultViewEvent.value = .loaded
    }
    
    func airlineList() -> [String] {
        guard let flightList = self.flightList else { return [] }
        var tempArray: [String] = []
        for flightItem in flightList {
            guard let airline = flightItem.airline else { continue }
            if !tempArray.contains(airline) {
                tempArray.append(airline)
            }
        }
        return tempArray
    }
    
    // MARK: - Private Methods
    
    private func travelRequest(bySearchFormModel searchModel: HomeSearchFormModel?) -> TravelRequest? {
        guard let searchModel = searchModel else { return nil }
        guard let originIATACode = searchModel.originText else { return nil }
        guard let destinationIATACode = searchModel.destinationText else { return nil }
        guard let numberOfTickets = searchModel.numberOfPassengers else { return nil }
        guard let numberOfTicketsInteger = Int(numberOfTickets) else { return nil }
        guard let departureDate = searchModel.dateOfTheTripText?.toDate(format: .ddMMyyyy) else { return nil }
        guard let arrivalDate = searchModel.lapDateText?.toDate(format: .ddMMyyyy) else { return nil }

        let travelRequest = TravelRequest(originIATACode: originIATACode, destinationIATACode: destinationIATACode, departureDate: departureDate, arrivalDate: arrivalDate, numberOfTickets: numberOfTicketsInteger)

        return travelRequest
    }
    
    private func createViewModel(withNewFlights flightList: [Flight]) {
        for flightItem in flightList {
            let viewModel = FlightTableViewCellViewModel(flightItem)
            flightViewModelViewModelList.append(viewModel)
        }
    }
}
