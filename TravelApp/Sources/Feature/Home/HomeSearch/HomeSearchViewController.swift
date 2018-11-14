//
//  HomeSearchViewController.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController, Identifiable {

    //MARK: - Properties
    var searchWasClicked: ((HomeSearchFormModel) -> Void)?
    private var viewModel: HomeSearchViewModelProtocol?
    
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            scrollView.backgroundColor = UIColor.appPaleGrey
            scrollView.keyboardDismissMode = .interactive
        }
    }
    @IBOutlet private weak var stackView: UIStackView! {
        didSet {
            stackView.spacing = 20
        }
    }
    @IBOutlet private weak var originTextField: CustomTextField! {
        didSet {
            originTextField.placeholder = Localizable.homeSearchIATAOrigin.localize()
            originTextField.setRightImage(UIImage(named: "iconePin"))
            originTextField.accessibilityIdentifier = "originTextField"
        }
    }
    @IBOutlet weak var destinationTextField: CustomTextField! {
        didSet {
            destinationTextField.placeholder = Localizable.homeSearchIATADestination.localize()
            destinationTextField.setRightImage(UIImage(named: "iconePin"))
            destinationTextField.accessibilityIdentifier = "destinationTextField"
        }
    }
    @IBOutlet weak var dateOfTheTripTextField: CustomTextField! {
        didSet {
            dateOfTheTripTextField.placeholder = Localizable.homeSearchDateOfTheTrip.localize()
            dateOfTheTripTextField.setRightImage(UIImage(named: "iconeCalendario"))
            dateOfTheTripTextField.accessibilityIdentifier = "dateOfTheTripTextField"

            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = .date
            datePickerView.minimumDate = Date().add(component: .day, value: -1)
            datePickerView.locale = Locale.appLocale()
            dateOfTheTripTextField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet weak var lapDateTextField: CustomTextField! {
        didSet {
            lapDateTextField.placeholder = Localizable.homeSearchLapDate.localize()
            lapDateTextField.setRightImage(UIImage(named: "iconeCalendario"))
            lapDateTextField.accessibilityIdentifier = "lapDateTextField"

            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = .date
            datePickerView.minimumDate = Date().add(component: .day, value: -1)
            datePickerView.locale = Locale.appLocale()
            lapDateTextField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        }
    }
    @IBOutlet weak var numberOFPassengersTextField: CustomTextField! {
        didSet {
            numberOFPassengersTextField.placeholder = Localizable.homeSearchNumberOfPassengers.localize()
            numberOFPassengersTextField.setRightImage(UIImage(named: "passageiros"))
            numberOFPassengersTextField.text = "1"
            numberOFPassengersTextField.accessibilityIdentifier = "numberOFPassengersTextField"

            let thePicker = UIPickerView()
            thePicker.delegate = self
            thePicker.dataSource = self
            numberOFPassengersTextField.inputView = thePicker
        }
    }
    
    @IBOutlet private weak var searchTicketButton: UIButton! {
        didSet {
            searchTicketButton.applyCustomAppearance()
            searchTicketButton.setImage(UIImage(named: "btnUnselectedBranco"), for: .normal)
            searchTicketButton.setTitle(Localizable.homeSearchSearchTicket.localize(), for: .normal)
            searchTicketButton.accessibilityIdentifier = "searchTicketButton"
        }
    }
    
    // MARK: - Life Cycle Methods
    
    static func instantiate(viewModel: HomeSearchViewModelProtocol = HomeSearchViewModel()) -> HomeSearchViewController {
        let viewController: HomeSearchViewController = UIStoryboard.viewController(from: .home)
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setTopazStyle()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Action Methods
    
    @IBAction func didTouchSearchTicketButton(_ sender: UIButton) {
        view.endEditing(true)
        
        let formModel = HomeSearchFormModel(originText: originTextField.text, destinationText: destinationTextField.text, dateOfTheTripText: dateOfTheTripTextField.text, lapDateText: lapDateTextField.text, numberOfPassengers: numberOFPassengersTextField.text)
        viewModel?.validateForm(withForm: formModel)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        if lapDateTextField.inputView == sender {
            lapDateTextField.text = sender.date.toString(format: .ddMMyyyy)
        } else if dateOfTheTripTextField.inputView == sender {
            dateOfTheTripTextField.text = sender.date.toString(format: .ddMMyyyy)
        }
    }
    
    // MARK: - Private Methods
    
    private func bindView() {
        viewModel?.searchFormState.bind({ [weak self] (searchFormState) in
            guard let weakSelf = self, let searchFormState = searchFormState else { return }

            switch searchFormState {
            case .success(let searchFormModel):
                weakSelf.searchWasClicked?(searchFormModel)
            case .iataOriginError(let errorMessage):
                weakSelf.originTextField.setErrorMessage(errorMessage)
            case .iataDestinationError(let errorMessage):
                weakSelf.destinationTextField.setErrorMessage(errorMessage)
            case .dateOfTheTripError(let errorMessage):
                weakSelf.dateOfTheTripTextField.setErrorMessage(errorMessage)
            case .lapDateError(let errorMessage):
                weakSelf.lapDateTextField.setErrorMessage(errorMessage)
            case .numberOfPassengersError(let errorMessage):
                weakSelf.numberOFPassengersTextField.setErrorMessage(errorMessage)
            }
        })
    }
    
    private func setupView() {
        let logo = UIImageView(image: UIImage(named: "AirplaneNavTitle"))
//        logo.contentMode = .scaleAspectFill
//        logo.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.titleView = logo
        title = "Home"
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let kbRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbRect.size.height, right: 0)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbRect.size.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: CATransaction.animationDuration()) {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension HomeSearchViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 9
    }
}

extension HomeSearchViewController: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row+1)
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOFPassengersTextField.text = String(row+1)
    }
}
