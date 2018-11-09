//
//  Identifiable.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

import UIKit

// MARK: - Identifiable protocol

/// Used to UIViewController that are stored in Storyboard
protocol Identifiable: class {
    
}

// MARK: - NibLoadableView protocol

/// Used to UIViewController that are stored in Storyboard
protocol NibLoadableView: class {
    
}

// MARK: - Identifiable Extension on UIViewController
extension Identifiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static var segueIdentifier: String {
        let identifier = String(describing: self)
        let vcString = "ViewController"
        let endIndex = identifier.index(identifier.endIndex, offsetBy: -vcString.count)
        return String(identifier[identifier.startIndex..<endIndex])
    }
}

// MARK: - Identifiable Extension on UITableViewCell
extension Identifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Identifiable Extension on UICollectionViewCell
extension Identifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Identifiable Extension on UITableViewHeaderFooterView
extension Identifiable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - NibLoadableView Extension on UIView
extension NibLoadableView where Self: UIView {
    
    /// Retrieves nibName by class name
    static var nibName: String {
        return String(describing: self)
    }
}
