//
//  AppDelegate.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var homeSearchFlow: HomeFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] != "1" {
            let flowConfigure = FlowConfigure(window: window, navigationController: UINavigationController(), parent: nil)
            homeSearchFlow = HomeFlowController(configure: flowConfigure)
            homeSearchFlow?.start()
        } else {
            window?.rootViewController = UIViewController()
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

