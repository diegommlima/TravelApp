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

typealias DynamicStubParameterTuple = (queryString: String, fileName: String)?

class HTTPDynamicStubs {
    
    // MARK: - Properties
    private var server = HttpServer()
    static let shared = HTTPDynamicStubs()
    
    // MARK: - Public Methods
    public func setUp() {
        server = HttpServer()
        try! server.start()
    }
    
    public func tearDown() {
        server.stop()
    }

    public func setupStub(models: [HTTPStubInfo], file: StaticString = #file, line: UInt = #line) {
        
        let model = models.first!
        
        guard let data = LocalJsonReader.retrieveData(fromFile: model.jsonFilename) else {
            XCTFail("erro", file: file, line: line)
            return
        }
        
        let json = dataToJSON(data: data)
        
        // Swifter makes it very easy to create stubbed responses
        let response: ((HttpRequest) -> HttpResponse) = { request in
            //            guard parameter != nil, request.queryParams.contains(where: { $0 == parameter! }) else {
            //                return HttpResponse.notFound
            //            }
            Thread.sleep(forTimeInterval: model.delay)
            return HttpResponse.ok(.json(json as AnyObject))
        }
        
        switch model.method  {
        case .GET : server.GET[model.url] = response
        case .POST: server.POST[model.url] = response
        }
    }
    
    // MARK: - Private Methods
    
    private init(){}
    
    private static var httpStub: HTTPDynamicStubs = {
        let httpStub = HTTPDynamicStubs()
        return httpStub
    }()
    
    private func dataToJSON(data: Data) -> Any? {
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
    let delay: TimeInterval
    let method: HTTPMethod
    let queryParameter: String?
    
    init(url: String, jsonFileName: String, delay: TimeInterval = 0, method: HTTPMethod = .GET, queryParameter: String? = nil) {
        self.url = url
        self.jsonFilename = jsonFileName
        self.delay = delay
        self.method = method
        self.queryParameter = queryParameter
    }
}

