//
//  UIView.swift
//  TravelApp
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UIView {
    
    static func fromNib<T>(withOwner: Any? = nil, options: [AnyHashable: Any]? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib.instantiate(withOwner: withOwner, options: options).first as? T
    }
}
