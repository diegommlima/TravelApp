//
//  SearchRequest.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation


class SearchRequest: SearchRequestProtocol {
    
    // MARK: - Constants
    
    private let apiSearchEndpoint = "/api/search"
    
    // MARK: - Properties
    
    private var apiProvider: GoibiboApiProvider
    
    // MARK: - Initializer Functions
    
    init(withProvider aProvider: NetworkProtocol?) {
        apiProvider = GoibiboApiProvider(networking: aProvider)
    }
    
    func fetchFlights(withModelRequest requestModel: TravelRequest, completion:@escaping SearchFlightCallback) {
        
        let parameters = NetworkParameters(nil, requestModel.encodedDictionary)

        _ = apiProvider.networking.GET(apiSearchEndpoint, parameters: parameters, header: NetworkProvider.headers(), completion: { (response) in
            do {
                let (_, data) = try response()
                let responseData: TravelResponse = try JSONDecoder().decode(TravelResponse.self, from: data)
                completion { responseData.travels }
            } catch {
                completion { throw TechnicalError.unableToRetrieveData }
            }
        })
    }
}
