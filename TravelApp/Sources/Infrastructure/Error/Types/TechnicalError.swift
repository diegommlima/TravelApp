//
//  TechnicalError.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum TechnicalError: Swift.Error {
    case httpError(Int, Data?)
    case parse(String)
    case requestError(String)
    case timeoutError
    case invalidURL
    case notFound
    case notConnected
    case unableToRetrieveData
    case emptyResult
    case invalidParse
    case machErrorDomain(Int)
}

// MARK: - Handle error protocol

extension TechnicalError: HandleError {
    func handle(completion: () -> Void) {
        switch self {
        case .httpError(let code):
            print("Code: \(code)")
        default:
            print("Handle specific tecnical errors here as it become necessary to keep it uniform through the all app")
        }
        
        completion()
    }
}
