//
//  UIBarButtonItem.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    static func backButton(target: Any?, selector: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(image: UIImage(named: "arrowBackBranco"), style: .plain, target: target, action: selector)
        barButton.tintColor = UIColor.white
        barButton.accessibilityLabel = Localizable.navBackAccessibilityLabel.localize()
        return barButton
    }
}
