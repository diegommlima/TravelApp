//
//  NetworkMockProvider.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation
@testable import TravelApp

/// Networking Mock connection provider, implements NetworkProtocol
final class NetworkMockProvider: NetworkProtocol, Mockable {
    // MARK: - Properties
    
    var mockType: MockType
    var returnStatusCode: Int
    private(set) var lastNetworkMockParameters: NetworkMockParameters?
    
    // MARK: - Initializers
    
    init(session: URLSession, baseURL: String) {
        self.mockType = .error(type: TechnicalError.invalidURL)
        self.returnStatusCode = 0
    }
    
    init(mockType: MockType) {
        self.mockType = mockType
        self.returnStatusCode = 0
    }
    
    init(mockType: MockType, returnStatusCode: Int) {
        self.mockType = mockType
        self.returnStatusCode = returnStatusCode
    }
    
    // MARK: - HTTP Verbs
    
    /// GET request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func GET(_ url: String,
             parameters: NetworkParameters?,
             header: NetworkHeader?,
             completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .get,
                                url: url,
                                parameters: parameters,
                                header: header,
                                completion: completion)
    }
    
    /// POST request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion:NetworkHeaderNetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func POST(_ url: String,
              parameters: NetworkParameters?,
              header: NetworkHeader,
              completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .post,
                                url: url,
                                parameters: parameters,
                                header: header,
                                completion: completion)
    }
    
    /// HEAD request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func HEAD(_ url: String,
              parameters: NetworkParameters?,
              header: NetworkHeader,
              completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .head,
                                url: url,
                                parameters: parameters,
                                header: header,
                                completion: completion)
    }
    
    /// PUT request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func PUT(_ url: String,
             parameters: NetworkParameters?,
             header: NetworkHeader,
             completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .put,
                                url: url,
                                parameters: parameters,
                                header: header,
                                completion: completion)
    }
    
    /// DELETE request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: Dictionary
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func DELETE(_ url: String,
                parameters: NetworkParameters?,
                header: NetworkHeader,
                completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        return self.dataTaskFor(httpMethod: .delete,
                                url: url,
                                parameters: parameters,
                                header: header,
                                completion: completion)
    }
    
    // MARK: - Private methods
    
    private func dataTaskFor(httpMethod: ServiceHTTPMethod,
                             url: String,
                             parameters: NetworkParameters?,
                             header: NetworkHeader?,
                             completion: @escaping NetworkCompletion) -> URLSessionTask? {
        
        lastNetworkMockParameters = NetworkMockParameters(httpMethod: httpMethod, url: url, networkParameters: parameters, networkHeader: header)
        
        switch mockType {
        case .json(let fileName):
            guard let data = LocalJsonReader.retrieveData(fromFile: fileName) else {
                completion { throw TechnicalError.notFound }
                
                return nil
            }
            
            completion { (HTTPURLResponse(url: URL.init(string: url)!, statusCode: self.returnStatusCode, httpVersion: "", headerFields: [:])!, data) }
        case .error(let error):
            completion { throw error }
        default:
            completion { throw TechnicalError.notFound }
        }
        
        return URLSessionTask()
    }
}
