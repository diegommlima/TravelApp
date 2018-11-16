//
//  UIImage.swift
//  TravelAppUITests
//
//  Created by Diego Lima on 16/11/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UIImage {
    var removingStatusBarTime: UIImage? {
        
        let imageSize = size
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        draw(at: .zero)
        
        //TODO: Needs to be adapted to new Screens (ex. IphoneX)
        let rectangle = CGRect(x: (imageSize.width-100)/2, y: 0, width: 100, height: 20)
        
        context.setFillColor(UIColor.black.cgColor)
        context.addRect(rectangle)
        context.drawPath(using: .fill)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
