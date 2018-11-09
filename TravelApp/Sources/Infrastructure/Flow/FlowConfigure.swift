//
//  FlowConfigure.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class FlowConfigure {
    // MARK: - Properties
    
    let window: UIWindow?
    let navigationController: UINavigationController?
    let parent: FlowControllable?
    
    // MARK: - Initiatlizers
    
    init(window: UIWindow? = nil, navigationController: UINavigationController?, parent: FlowControllable?) {
        self.window = window
        self.navigationController = navigationController
        self.parent = parent
    }
}
