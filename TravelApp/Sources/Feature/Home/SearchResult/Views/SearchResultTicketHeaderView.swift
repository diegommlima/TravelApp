//
//  SearchResultTicketHeaderView.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class SearchResultTicketHeaderView: UITableViewHeaderFooterView, Identifiable, NibLoadableView {

    //MARK: - Constants
    
    static let heightForHeader: CGFloat = 40
    
    //MARK: - Properties

    @IBOutlet private weak var contentBackgroundView: UIView! {
        didSet {
            contentBackgroundView.backgroundColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet private weak var airlineLabel: UILabel! {
        didSet {
            airlineLabel.font = UIFont.appTextStyle4
            airlineLabel.textColor = UIColor.appWhiteTwo
            airlineLabel.text = Localizable.searchResultAirline.localize()
        }
    }
    @IBOutlet private weak var departLabel: UILabel! {
        didSet {
            departLabel.font = UIFont.appTextStyle4
            departLabel.textColor = UIColor.appWhiteTwo
            departLabel.text = Localizable.searchResultDepart.localize()
        }
    }
    @IBOutlet private weak var durationLabel: UILabel! {
        didSet {
            durationLabel.font = UIFont.appTextStyle4
            durationLabel.textColor = UIColor.appWhiteTwo
            durationLabel.text = Localizable.searchResultDuration.localize()
        }
    }
    @IBOutlet private weak var arrivalLabel: UILabel! {
        didSet {
            arrivalLabel.font = UIFont.appTextStyle4
            arrivalLabel.textColor = UIColor.appWhiteTwo
            arrivalLabel.text = Localizable.searchResultArrival.localize()
        }
    }
}
