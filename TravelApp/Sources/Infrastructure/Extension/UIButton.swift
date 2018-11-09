//
//  UIButton.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UIButton {
    
    func applyCustomAppearance() {
        titleLabel?.font = UIFont.appTextStyle5
        tintColor = UIColor.appWhiteTwo
        imageEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 16)
        titleEdgeInsets = UIEdgeInsetsMake(4, 0, 0, 0)
        layer.cornerRadius = 4.0
        layer.backgroundColor = UIColor.appTopaz.cgColor
        layer.shadowColor = UIColor.appBlueGreen.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
    }
    
    func applyCustomAppearance2() {
        backgroundColor = UIColor.white
        setTitleColor(UIColor.appSteelGrey, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        tintColor = UIColor.appTopaz
        titleLabel?.font = UIFont.appTextStyle6
    }
}
