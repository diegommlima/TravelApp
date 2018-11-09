//
//  UITableView.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Identifiable {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue HeaderFooter with identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
    
    /**
     Register a Class-Based `UITableViewCell` subclass (conforming to `Identifiable`)
     - parameter cellType: the `UITableViewCell` (`Identifiable`-conforming) subclass to register
     */
    final func register<T: UITableViewCell>(cellType: T.Type) where T: Identifiable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a NIB-Based `UITableViewCell` subclass (conforming to `Identifiable` & `NibLoadableView`)
     - parameter cellType: the `UITableViewCell` (`Identifiable` & `NibLoadableView`-conforming) subclass to register
     */
    final func register<T: UITableViewCell>(cellType: T.Type) where T: Identifiable & NibLoadableView {
        let bundle = Bundle(for: cellType.self)
        let nib = UINib(nibName: cellType.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /**
     Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `Identifiable` & `NibLoadableView`)
     - parameter cellType: the `UITableViewHeaderFooterView` (`Identifiable` & `NibLoadableView`-conforming) subclass to register
     */
    final func register<T: UITableViewHeaderFooterView>(cellType: T.Type) where T: Identifiable & NibLoadableView {
        let bundle = Bundle(for: cellType.self)
        let nib = UINib(nibName: cellType.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: cellType.reuseIdentifier)
    }
}
