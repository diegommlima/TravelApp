//
//  Date.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: AppDateFormat) -> String {
        let dateFormat = DateFormatter.appDateFormatter(withFormat: format)
        return dateFormat.string(from: self)
    }
    
    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }
    
    func isTheSameDay(date: Date) -> Bool {
        let result = Calendar.current.isDate(self, inSameDayAs: date)
        return result
    }
    
    func isTheSameMonth(date: Date) -> Bool {
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.month], from: date1, to: date2)
        return components.month == 0
    }
    
    func differenceBetweenDays(date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
}
