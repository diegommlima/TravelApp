//
//  BusinessError.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum BusinessError: Error {
    case parse(String)
    case invalidValue(String)
    case invalidResponse
    case offlineMode
    case loggedOut
}

// MARK: - Handle error protocol

extension BusinessError: HandleError {
    func handle(completion: () -> Void) {
        switch self {
        case .offlineMode:
            print("Network not reachable")
        default:
            print("Handle specific tecnical errors here as it become necessary to keep it uniform through the all app")
        }
        
        completion()
    }
}
