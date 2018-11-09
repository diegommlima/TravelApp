//
//  CustomTextField.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    private let rightViewWidth: CGFloat = 42.0
    private let contentPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 34)
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.appTextStyle0
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.frame = CGRect(x: contentPadding.left, y: frame.size.height - 16.0, width: frame.size.width - contentPadding.left, height: 12.0)
        addSubview(errorLabel)
        return errorLabel
    }()
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK: - Override
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, contentPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, contentPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, contentPadding)
    }
    
    //MARK: - Public Methods
    
    func setRightImage(_ rightImage: UIImage?) {
        let imageView = UIImageView(image: rightImage)
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: rightViewWidth, height: frame.size.height)
        imageView.autoresizingMask = .flexibleHeight
        rightView = imageView
    }

    func setErrorMessage(_ errorMessage: String?) {
        errorLabel.text = errorMessage
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        doneAccessory = true
        autocorrectionType = .no
        rightViewMode = .always
        borderStyle = .none
        font = UIFont.appTextStyle
        textColor = UIColor.appCoolGrey
        layer.backgroundColor = UIColor.appWhiteTwo.cgColor
        layer.borderColor = UIColor.appSilver.cgColor
        layer.borderWidth = 1
        layer.shadowColor = UIColor.appSilver50.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        addTarget(self, action: #selector(beginEditing), for: .editingDidBegin)
    }
    
    @objc private func beginEditing() {
        if let datePicker = inputView as? UIDatePicker {
            datePicker.sendActions(for: .valueChanged)
        }

        errorLabel.text = nil
    }
}
