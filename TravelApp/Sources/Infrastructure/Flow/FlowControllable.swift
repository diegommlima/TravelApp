//
//  FlowControllable.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

protocol FlowControllable: class {
    // MARK: - Initializers
    
    init(configure: FlowConfigure)
    
    // MARK: - Methods
    
    func start()
}
