//
//  SearchRequestProtocol.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

typealias SearchFlightCallback = (@escaping () throws -> [Flight]?) -> Void

protocol SearchRequestProtocol {
    
    func fetchFlights(withModelRequest requestModel: TravelRequest, completion:@escaping SearchFlightCallback)
    
}
