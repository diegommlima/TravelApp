//
//  LocalJsonReader.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 18/11/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

class LocalJsonReader {
    // MARK: - Properties
    
    private static let jsonExtension = "json"
    
    // MARK: - Public Functions
    
    static func retrieveData(fromFile name: String?) -> Data? {
        let bundle = Bundle(for: type(of: LocalJsonReader()))
        
        guard let name = name else {
            return nil
        }
        
        guard let pathString = bundle.path(forResource: name, ofType: jsonExtension) else {
            return nil
        }
        
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: String.Encoding.utf8) else {
            return nil
        }
        
        guard let jsonData = jsonString.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return jsonData
    }
}
