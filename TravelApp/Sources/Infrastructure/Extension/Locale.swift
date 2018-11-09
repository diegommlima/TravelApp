//
//  Locale.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

extension Locale {
    
    private static let kPTBRLocale = "pt_BR"

    static func appLocale() -> Locale {
        return Locale(identifier: kPTBRLocale)
    }
}
