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
    
    public func setupStub(_ stubModel: HTTPStubInfo, httpRespose: HttpResponse? = nil, file: StaticString = #file, line: UInt = #line) {
        
        var response: ((HttpRequest) -> HttpResponse)
        if let httpRespose = httpRespose {
            response = { request in
                Thread.sleep(forTimeInterval: stubModel.delay)
                return httpRespose
            }
        } else {
            guard let data = LocalJsonReader.retrieveData(fromFile: stubModel.jsonFilename) else {
                XCTFail("Json cannot be retrieved", file: file, line: line)
                return
            }
            let json = self.dataToJSON(data: data, file: file, line: line)
            
            response = { request in
                Thread.sleep(forTimeInterval: stubModel.delay)
                return HttpResponse.ok(.json(json as AnyObject))
            }
        }
        
        switch stubModel.method  {
        case .GET : server.GET[stubModel.url] = response
        case .POST: server.POST[stubModel.url] = response
        }
    }
    
    // MARK: - Private Methods
    
    private init(){}
    
    private static var httpStub: HTTPDynamicStubs = {
        let httpStub = HTTPDynamicStubs()
        return httpStub
    }()
    
    private func dataToJSON(data: Data, file: StaticString = #file, line: UInt = #line) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            XCTFail("Json cannot be parsed error: \(myJSONError)", file: file, line: line)
        }
        return nil
    }
}

struct HTTPStubInfo {
    let url: String
    let jsonFilename: String?
    let delay: TimeInterval
    let method: HTTPMethod
    
    init(url: String, jsonFileName: String? = nil, delay: TimeInterval = 0, method: HTTPMethod = .GET) {
        self.url = url
        self.jsonFilename = jsonFileName
        self.delay = delay
        self.method = method
    }
}
