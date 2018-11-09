//
//  GoibiboApiProvider.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

struct GoibiboApiProvider {
    
    static let appID = "04b76e21"
    static let appKey = "fadc0a120521b900ba893016c766c83f"
    let networking: NetworkProtocol
    
    private let baseURL = "http://developer.goibibo.com"

    init(networking networkingProtocol: NetworkProtocol? = nil) {
        if let networking = networkingProtocol {
            self.networking = networking
        } else {
            let urlSession = URLSession(configuration: .ephemeral,
                                        delegate: nil,
                                        delegateQueue: nil)
            self.networking = NetworkProvider(session: urlSession, baseURL: baseURL)
        }
    }
}
