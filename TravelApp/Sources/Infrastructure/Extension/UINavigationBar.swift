//
//  UINavigationBar.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setTopazStyle() {
        barStyle = .black
        isTranslucent = false
        shadowImage = UIImage()
        setBackgroundImage(UIImage(named: "navBarTopaz")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .default)
        titleTextAttributes = [NSAttributedString.Key.font: UIFont.appTextStyle5,
                               NSAttributedString.Key.foregroundColor: UIColor.appWhiteTwo]
    }
}
