//
//  String.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

extension String {
    
    /// Wrapper method to access Localized string
    ///
    /// - Parameter isAccessibilty: If it's an acessibility label string
    /// - Returns: String from Localizable.strings file
    func localize(isAccessibilty: Bool = false) -> String {
        return NSLocalizedString(self, tableName: isAccessibilty ? "LocalizableAccessibility" : "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
    
    func toDate(format: AppDateFormat) -> Date? {
        let dateFormat = DateFormatter.appDateFormatter(withFormat: format)
        return dateFormat.date(from: self)
    }
}
