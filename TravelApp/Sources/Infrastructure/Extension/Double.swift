//
//  Double.swift
//  TravelApp
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

extension Double {
    

    func toCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.appLocale()
        
        if let currencyFormatted = currencyFormatter.string(from: NSNumber(value: self)) {
            return currencyFormatted
        }
        return String()
    }
}
