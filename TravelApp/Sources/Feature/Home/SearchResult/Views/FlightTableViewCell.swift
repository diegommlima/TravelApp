//
//  FlightTableViewCell.swift
//  TravelApp
//
//  Created by Diego Lima on 09/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell, Identifiable, NibLoadableView {

    @IBOutlet weak var goingLabel: UILabel! {
        didSet {
            goingLabel.font = UIFont.appTextStyle2
            goingLabel.textColor = UIColor.appCoolGrey
            goingLabel.text = Localizable.searchResultGoing.localize().uppercased()
        }
    }
    @IBOutlet weak var depAirplaneLabel: UILabel! {
        didSet {
            depAirplaneLabel.font = UIFont.appTextStyle7
            depAirplaneLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var depFlightCodeLabel: UILabel! {
        didSet {
            depFlightCodeLabel.font = UIFont.appTextStyle3
            depFlightCodeLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var arrowImageView: UIImageView! {
        didSet {
            arrowImageView.contentMode = .center
            arrowImageView.image = UIImage(named: "arrowFlightGoing.png")
        }
    }
    @IBOutlet weak var depTimeFlightLabel: UILabel! {
        didSet {
            depTimeFlightLabel.font = UIFont.appTextStyle7
            depTimeFlightLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var depAirportLabel: UILabel! {
        didSet {
            depAirportLabel.font = UIFont.appTextStyle3
            depAirportLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont.appTextStyle4
            dateLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var durationLabel: UILabel! {
        didSet {
            durationLabel.font = UIFont.appTextStyle4
            durationLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var stopOverLabel: UILabel! {
        didSet {
            stopOverLabel.font = UIFont.appTextStyle3
            stopOverLabel.textColor = UIColor.appCoolGrey
            stopOverLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var arrTimeFlightLabel: UILabel! {
        didSet {
            arrTimeFlightLabel.font = UIFont.appTextStyle6
            arrTimeFlightLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var arrAirportLabel: UILabel! {
        didSet {
            arrAirportLabel.font = UIFont.appTextStyle3
            arrAirportLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var flightLineView: UIImageView! {
        didSet {
            flightLineView.image = UIImage(named: "LineCell.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }

    @IBOutlet weak var returnGoingLabel: UILabel! {
        didSet {
            returnGoingLabel.font = UIFont.appTextStyle2
            returnGoingLabel.textColor = UIColor.appCoolGrey
            returnGoingLabel.text = Localizable.searchResultBack.localize().uppercased()
        }
    }
    @IBOutlet weak var returnDepAirplaneLabel: UILabel! {
        didSet {
            returnDepAirplaneLabel.font = UIFont.appTextStyle7
            returnDepAirplaneLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnDepFlightCodeLabel: UILabel! {
        didSet {
            returnDepFlightCodeLabel.font = UIFont.appTextStyle3
            returnDepFlightCodeLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnArrowImageView: UIImageView! {
        didSet {
            returnArrowImageView.contentMode = .center
            returnArrowImageView.image = UIImage(named: "arrowFlightReturn.png")
        }
    }
    @IBOutlet weak var returnDepTimeFlightLabel: UILabel! {
        didSet {
            returnDepTimeFlightLabel.font = UIFont.appTextStyle7
            returnDepTimeFlightLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnDepAirportLabel: UILabel! {
        didSet {
            returnDepAirportLabel.font = UIFont.appTextStyle3
            returnDepAirportLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnDateLabel: UILabel! {
        didSet {
            returnDateLabel.font = UIFont.appTextStyle4
            returnDateLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnDurationLabel: UILabel! {
        didSet {
            returnDurationLabel.font = UIFont.appTextStyle4
            returnDurationLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnStopOverLabel: UILabel! {
        didSet {
            returnStopOverLabel.font = UIFont.appTextStyle3
            returnStopOverLabel.textColor = UIColor.appCoolGrey
            returnStopOverLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var returnArrTimeFlightLabel: UILabel! {
        didSet {
            returnArrTimeFlightLabel.font = UIFont.appTextStyle6
            returnArrTimeFlightLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnArrAirportLabel: UILabel! {
        didSet {
            returnArrAirportLabel.font = UIFont.appTextStyle3
            returnArrAirportLabel.textColor = UIColor.appCoolGrey
        }
    }
    @IBOutlet weak var returnFlightLineView: UIImageView! {
        didSet {
            returnFlightLineView.image = UIImage(named: "LineCell.png")?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
    @IBOutlet private weak var contentBackgroundView: UIView! {
        didSet {
            contentBackgroundView.backgroundColor = UIColor.appWhiteTwo
            contentBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
            contentBackgroundView.layer.shadowRadius = 3
            contentBackgroundView.layer.shadowOpacity = 1
            contentBackgroundView.layer.shadowColor = UIColor.appPaleGrey24.cgColor
        }
    }
    
    @IBOutlet weak var buyButton: UIButton! {
        didSet {
            buyButton.applyCustomAppearance()
            buyButton.addTarget(self, action: #selector(didTouchBuyButton), for: .touchUpInside)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }

    //MARK: - Public Methods
    
    func setup(_ viewModel: FlightTableViewCellViewModel) {
        buyButton.setTitle(viewModel.farePrice, for: .normal)
        
        depAirplaneLabel.text = viewModel.airlineText
        depFlightCodeLabel.text = viewModel.flightCodeText
        depTimeFlightLabel.text = viewModel.departureTimeFlightText
        depAirportLabel.text = viewModel.departureAirportText
        dateLabel.text = viewModel.dateText
        durationLabel.text = viewModel.durationText
        stopOverLabel.text = viewModel.stopOverText
        arrTimeFlightLabel.text = viewModel.arrivalTimeFlightText
        arrAirportLabel.text = viewModel.arrivalAirportText
        
        if let returnViewModel = viewModel.returnFlightCellViewModelList?.first {
            returnDepAirplaneLabel.text = returnViewModel.airlineText
            returnDepFlightCodeLabel.text = returnViewModel.flightCodeText
            returnDepTimeFlightLabel.text = returnViewModel.departureTimeFlightText
            returnDepAirportLabel.text = returnViewModel.departureAirportText
            returnDateLabel.text = returnViewModel.dateText
            returnDurationLabel.text = returnViewModel.durationText
            returnStopOverLabel.text = returnViewModel.stopOverText
            returnArrTimeFlightLabel.text = returnViewModel.arrivalTimeFlightText
            returnArrAirportLabel.text = returnViewModel.arrivalAirportText
        }
    }
    
    //MARK: - Private Methods
    
    @objc private func didTouchBuyButton() {
        let alertVC = UIAlertController(title: "Comprar", message: "Por enquanto a opção de comprar não está disponível", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertVC.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
}
