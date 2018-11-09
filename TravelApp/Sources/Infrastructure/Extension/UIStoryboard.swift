//
//  UIStoryboard.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Creates a view controller from storyboard
    ///
    /// - Parameters:
    ///   - storyboard: storyboard name
    /// - Returns: view controller instance
    static func viewController<T: UIViewController>(from storyboard: UIStoryboard.Name) -> T where T: Identifiable {
        
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.self.storyboardIdentifier) as? T else {
            fatalError("Could instantiate ViewController with identifier: \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
    
    enum Name: String {
        case home = "Home"
    }
}
