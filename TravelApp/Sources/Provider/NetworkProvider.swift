//
//  NetworkProvider.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

/// Networking connection provider, implements NetworkProtocol
final class NetworkProvider: NetworkProtocol {
    // MARK: - Constants
    private static let reachabilityHost = "www.google.com"
    
    // MARK: - Properties
    private let session: URLSession
    private let baseURL: String
    
    // MARK: - Initializers
    
    /// Provider Networking Initializer
    ///
    /// - Parameters:
    ///   - session: URLSession
    ///   - baseURL: URL
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
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
    ///   - completion: NetworkingDictionaryCompletion
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
    ///   - header: NetworkHeader
    ///   - completion: NetworkingDictionaryCompletion
    /// - Returns: URLSessionTask
    func HEAD(_ url: String,
              parameters: NetworkParameters?,
              header: [String: String],
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
    ///   - header: NetworkHeader
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
    
    static func headers() -> NetworkHeader {
        return [:]
    }
    
    // MARK: - Private methods
    
    private func request(_ urlPath: String,
                         parameters: NetworkParameters?,
                         header: NetworkHeader?,
                         httpMethod: ServiceHTTPMethod) throws -> URLRequest {
        
        let request = NSMutableURLRequest()
        request.httpMethod = httpMethod.rawValue
        
        guard let completeURL = self.completeURL(urlPath) else {
            throw TechnicalError.invalidURL
            
        }
        guard var urlComponents: URLComponents = URLComponents(url: completeURL,
                                                               resolvingAgainstBaseURL: false) else {
                                                                throw TechnicalError.invalidURL
        }
        
        //checking if parameters are needed
        if let params = parameters {
            //adding parameters to body
            if let bodyParameters = params.bodyParameters {
                request.httpBody = bodyParameters
            }
            
            //adding parameters to query string
            if let json = params.queryParameters {
                let parametersItems: [String] = json.map({ (par) -> String in
                    let value = String(describing: par.1) != "" ? String(describing: par.1) : "null"
                    if value == "null" { return "" }
                    return "\(par.0)=\(value)"
                })
                
                urlComponents.query = parametersItems.joined(separator: "&")
            }
        }
        
        //setting url to request
        request.url = urlComponents.url
        request.cachePolicy = .reloadIgnoringCacheData
        
        //adding HEAD parameters
        request.allHTTPHeaderFields = header
        
        return request as URLRequest
    }
    
    private func completeURL(_ componentOrUrl: String) -> URL? {
        if componentOrUrl.contains("http://") || componentOrUrl.contains("https://") {
            return URL(string: componentOrUrl)
        } else {
            return URL(string: "\(baseURL)\(componentOrUrl)")
        }
    }
    
    private func dataTaskFor(httpMethod: ServiceHTTPMethod,
                             url: String,
                             parameters: NetworkParameters?,
                             header: NetworkHeader?,
                             completion: @escaping NetworkCompletion) -> URLSessionTask? {
        do {
            let request = try self.request(url,
                                           parameters: parameters,
                                           header: header,
                                           httpMethod: httpMethod)
            
            let sessionTask: URLSessionTask = session.dataTask(with: request,
                                                               completionHandler: {(data, response, error) -> Void  in
                                                                self.completionHandler(data: data,
                                                                                       response: response,
                                                                                       error: error,
                                                                                       completion: completion)
            })
            
            sessionTask.resume()
            
            return sessionTask
        } catch let errorRequest {
            DispatchQueue.main.async(execute: {
                completion { throw errorRequest }
            })
        }
        
        return nil
    }
    
    private func completionHandler(data: Data?,
                                   response: URLResponse?,
                                   error: Swift.Error?,
                                   completion: @escaping NetworkCompletion) {
        do {
            //check if there is no error
            if error != nil {
                throw error!
            }
            
            //unwraping httpResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                throw TechnicalError.parse("The NSHTTPURLResponse could not be parsed")
            }
            
            //check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                //trying to get the data
                guard let responseData = data else {
                    throw TechnicalError.parse("Error parsing Data from request: \(String(describing: httpResponse.url))")
                }
                
                DispatchQueue.main.async(execute: {
                    //success
                    completion { (httpResponse, responseData as Data) }
                })
            } else {
                //checking status of http
                throw TechnicalError.httpError(httpResponse.statusCode, data)
            }
        } catch let errorCallback {
            DispatchQueue.main.async(execute: {
                completion {
                    switch URLError.Code(rawValue: errorCallback._code) {
                    case .timedOut:
                        throw TechnicalError.timeoutError
                    case .notConnectedToInternet:
                        throw TechnicalError.notConnected
                    default:
                        throw errorCallback
                    }
                }
            })
        }
    }
}
