//
//  Dynamic.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias BindType = ((T) -> Void)
    
    //MARK: - Properties
    private var binds: [BindType] = []
    
    var value: T {
        didSet {
            self.execBinds()
        }
    }
    
    //MARK: - Initialize
    init(_ val: T) {
        value = val
    }
    
    //MARK: - Public Methods
    func bind(_ bind:@escaping BindType) {
        binds.append(bind)
        self.execBinds()
    }
    
    //MARK: - Private Methods
    private func execBinds() {
        self.binds.forEach { (bind) in
            bind(self.value)
        }
    }
}
