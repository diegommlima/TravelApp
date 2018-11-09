//
//  NetworkProtocol.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

public typealias NetworkCompletion = (() throws -> (HTTPURLResponse, Data)) -> Void
public typealias NetworkParameters = (bodyParameters: Data?, queryParameters: [String: Any]?)
public typealias NetworkHeader = [String: String]

/// Service HTTP Method
///
/// - get: GET Verb
/// - post: POST Verb
/// - head: HEAD Verb
/// - put: PUT Verb
/// - delete: DELETE Verb
enum ServiceHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
}

/// Methods necessary to access networking rest APIs
protocol NetworkProtocol {
    
    /// Provider Networking Initializer
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - baseURL: URL
    init(session: URLSession, baseURL: String)
    
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
             completion: @escaping NetworkCompletion) -> URLSessionTask?
    
    /// POST request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func POST(_ url: String,
              parameters: NetworkParameters?,
              header: NetworkHeader,
              completion: @escaping NetworkCompletion) -> URLSessionTask?
    
    /// HEAD request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func HEAD(_ url: String,
              parameters: NetworkParameters?,
              header: NetworkHeader,
              completion: @escaping NetworkCompletion) -> URLSessionTask?
    
    /// PUT request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func PUT(_ url: String,
             parameters: NetworkParameters?,
             header: NetworkHeader,
             completion: @escaping NetworkCompletion) -> URLSessionTask?
    
    /// DELETE request with Dictionary response
    ///
    /// - Parameters:
    ///   - url: String endpoint
    ///   - parameters: NetworkingParameters
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func DELETE(_ url: String,
                parameters: NetworkParameters?,
                header: NetworkHeader,
                completion: @escaping NetworkCompletion) -> URLSessionTask?
}
