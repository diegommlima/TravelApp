//
//  DateFormatter.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum AppDateFormat: String {
    case ddMMyyyy = "dd/MM/yyyy"
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddtHHmm = "yyyy-MM-dd't'HHmm"
    case HHmm = "HH:mm"
    case EEddofMM = "EE, dd 'de' MMMM"

}

extension DateFormatter {
        
    static func appDateFormatter(withFormat format: AppDateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale.appLocale()
        return formatter
    }
}
