//
//  HTTPDynamicStubs.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 16/11/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation
import Swifter
import XCTest

enum HTTPMethod {
    case POST
    case GET
}

class HTTPDynamicStubs {
    
    var server = HttpServer()
    
    func setUp() {
        try! server.start()
    }
    
    func tearDown() {
        server.stop()
    }
    
    public func setupStub(url: String, fileName: String, method: HTTPMethod = .GET, file: StaticString = #file, line: UInt = #line) {
        
        guard let data = LocalJsonReader.retrieveData(fromFile: fileName) else {
            XCTFail("erro", file: file, line: line)
            return
        }
//        let testBundle = Bundle(for: type(of: self))
//        let filePath = testBundle.path(forResource: filename, ofType: "json")
//        let fileUrl = URL(fileURLWithPath: filePath!)
//        let data = try! Data(contentsOf: fileUrl, options: .uncached)
        // Looking for a file and converting it to JSON
        let json = dataToJSON(data: data)
        
        // Swifter makes it very easy to create stubbed responses
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.json(json as AnyObject))
        }
        
        switch method  {
        case .GET : server.GET[url] = response
        case .POST: server.POST[url] = response
        }
    }
    
    func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}

struct HTTPStubInfo {
    let url: String
    let jsonFilename: String
    let method: HTTPMethod
}

