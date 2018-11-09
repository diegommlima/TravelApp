//
//  Data.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

extension Data {
    
    /// Converts Data to Dictionary
    ///
    /// - Returns: dictionary from data
    /// - Throws: invalid parse error
    func toDictionary() throws -> NSDictionary {
        guard let searchDictionary = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? NSDictionary else {
            throw TechnicalError.invalidParse
        }
        return searchDictionary
    }
    
    /// Converts Data to Array
    ///
    /// - Returns: array from data
    /// - Throws: invalid parse error
    func toArray() throws -> NSArray {
        guard let searchDictionary = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves) as? NSArray else {
            throw TechnicalError.invalidParse
        }
        return searchDictionary
    }
    
}
