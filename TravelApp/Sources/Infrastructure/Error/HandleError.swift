//
//  HandleError.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

protocol HandleError {
    func handle(completion: () -> Void)
}
