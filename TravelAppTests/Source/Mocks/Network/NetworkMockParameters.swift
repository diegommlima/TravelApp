//
//  NetworkMockParameters.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

@testable import TravelApp

enum NetworkMockParameterEnum {
    case invalidHttpMethod(ServiceHTTPMethod?)
    case invalidURL(String?)
    case invalidNetworkParameter
    case invalidHeader
    case emptyParameters
}

struct NetworkMockParameters {
    
    // MARK: - Properties
    
    let httpMethod: ServiceHTTPMethod?
    let url: String?
    let networkParameters: NetworkParameters?
    let networkHeader: NetworkHeader?
    
    // MARK: - Initializers
    
    init(httpMethod: ServiceHTTPMethod? = nil,
         url: String? = nil,
         networkParameters: NetworkParameters? = nil,
         networkHeader: NetworkHeader? = nil) {
        self.httpMethod = httpMethod
        self.url = url
        self.networkParameters = networkParameters
        self.networkHeader = networkHeader
    }
    
    // MARK: - Public methods
    
    func compare(to networkMockParameters: NetworkMockParameters?) -> [NetworkMockParameterEnum] {
        
        guard let networkMockParameters = networkMockParameters else {
            return [.emptyParameters]
        }
        
        var errorArray: [NetworkMockParameterEnum] = []
        if url != networkMockParameters.url {
            errorArray.append(.invalidURL(networkMockParameters.url))
        }
        if  httpMethod != networkMockParameters.httpMethod {
            errorArray.append(.invalidHttpMethod(networkMockParameters.httpMethod))
        }
        
        if let expectedDict = networkParameters?.queryParameters,
            let receivedDict = networkMockParameters.networkParameters?.queryParameters {
            if !compareDict(leftDict: expectedDict, rightDict: receivedDict) {
                errorArray.append(.invalidNetworkParameter)
            }
        }
        
        if networkParameters?.bodyParameters != networkMockParameters.networkParameters?.bodyParameters {
            errorArray.append(.invalidNetworkParameter)
        }
        
        if let expectedDict = networkHeader,
            let receivedDict = networkMockParameters.networkHeader {
            if !compareDict(leftDict: expectedDict, rightDict: receivedDict) {
                errorArray.append(.invalidHeader)
            }
        }
        
        return errorArray
    }
    
    // MARK: - Private methods
    
    private func compareDict(leftDict: [String: Any], rightDict: [String: Any]) -> Bool {
        let leftArray = parametersToArray(leftDict)
        let rightArray = parametersToArray(rightDict)
        return leftArray == rightArray
    }
    
    private func parametersToArray(_ parameters: [String: Any]) -> [String] {
        let parametersItems: [String] = parameters.map({ (par) -> String in
            let value = String(describing: par.1) != "" ? String(describing: par.1) : "null"
            if value == "null" { return "" }
            return "\(par.0)=\(value)"
        })
        return parametersItems
    }
}
