//
//  SearchResultErrorView.swift
//  TravelApp
//
//  Created by Diego Marlon Medeiros Lima on 11/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

protocol SearchResultErrorViewProtocol: class {
    func didClickTryAgain(errorView: SearchResultErrorView)
}

class SearchResultErrorView: UIView, NibLoadableView {

    //MARK: - Properties
    weak var delegate: SearchResultErrorViewProtocol?

    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.font = UIFont.systemFont(ofSize: 28)
            messageLabel.textColor = UIColor.appCoolGrey
            messageLabel.text = "Ocorreu um erro, por favor tente novamente."
        }
    }
    @IBOutlet weak var errorButton: UIButton! {
        didSet {
            errorButton.applyCustomAppearance()
            errorButton.setTitle("Tentar novamente", for: .normal)
        }
    }
    
     //MARK: - Actions
    
    @IBAction func didTouchToTryAgain(_ sender: Any) {
        delegate?.didClickTryAgain(errorView: self)
    }
}
