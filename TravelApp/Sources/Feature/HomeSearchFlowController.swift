//
//  HomeSearchFlowController.swift
//  MaxMilhas
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation
import UIKit

class HomeFlowController: FlowControllable {
    
    // MARK: - Properties
    
    private let configure: FlowConfigure
    
    // MARK: - Initializers
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    // MARK: - Public Functions
    
    func start() {
        configure.window?.rootViewController = configure.navigationController
        let homeSearchVC = HomeSearchViewController.instantiate()
        homeSearchVC.searchWasClicked = openSearchResult
        configure.navigationController?.viewControllers = [homeSearchVC]
    }
    
    func openSearchResult(withForm searchFormModel: HomeSearchFormModel) {
        
        let viewController = UIViewController()
        configure.navigationController?.pushViewController(viewController, animated: true)
    }
}
