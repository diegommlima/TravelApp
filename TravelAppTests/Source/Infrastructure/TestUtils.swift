//
//  TestUtils.swift
//  TravelAppTests
//
//  Created by Diego Marlon Medeiros Lima on 10/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

class TestUtils {
    
    static func JSONFromMock(resource: String) -> NSDictionary? {
        
        let bundle = Bundle(for: TestUtils.self)
        if let path = bundle.path(forResource: resource, ofType: "json") {
            do {
                let jsonData =  try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary {
                    return jsonResult
                }
            } catch {
                print("Error on method JSONFromMockWithResource")
            }
        }
        return nil
    }
    
}
