//
//  HomeSearchViewModel.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

enum HomeSearchFormViewStates {
    case success(searchFormModel: HomeSearchFormModel)
    case iataOriginError(errorMessage: String)
    case iataDestinationError(errorMessage: String)
    case dateOfTheTripError(errorMessage: String)
    case lapDateError(errorMessage: String)
    case numberOfPassengersError(errorMessage: String)
}

class HomeSearchViewModel: HomeSearchViewModelProtocol {
    
    var searchFormState: Dynamic<HomeSearchFormViewStates?> = Dynamic(nil)
    
    //MARK: - Public Methods
    
    func validateForm(withForm model: HomeSearchFormModel) {
        guard validateForm(model: model) else { return }
        searchFormState.value = .success(searchFormModel: model)
    }

    //MARK: - Private Methods
    
    private func validateForm(model: HomeSearchFormModel) -> Bool {
        var success = true
        // IATA Origin Validation
        let iataOriginErrorMessage = validateIATAField(iataText: model.originText)
        if let errorMessage = iataOriginErrorMessage {
            searchFormState.value = .iataOriginError(errorMessage: errorMessage)
            success = false
        }
        
        // IATA Destination Validation
        let iataDestinationErrorMessage = validateIATAField(iataText: model.destinationText)
        if let errorMessage = iataDestinationErrorMessage {
            searchFormState.value = .iataDestinationError(errorMessage: errorMessage)
            success = false
        }
        
        // Date of the trip Validation
        let dateOfTheTripErrorMessagep = validateDateField(dateText: model.dateOfTheTripText)
        if let errorMessage = dateOfTheTripErrorMessagep {
            searchFormState.value = .dateOfTheTripError(errorMessage: errorMessage)
            success = false
        }
        
        // Lap Date Validation
        let lapDateErrorMessagep = validateDateField(dateText: model.lapDateText)
        if let errorMessage = lapDateErrorMessagep {
            searchFormState.value = .lapDateError(errorMessage: errorMessage)
            success = false
        }
        
        // Number of passengers Validation
        let numberOfPassengersErrorMessagep = validateNumberOfPassengersField(numberText: model.numberOfPassengers)
        if let errorMessage = numberOfPassengersErrorMessagep {
            searchFormState.value = .numberOfPassengersError(errorMessage: errorMessage)
            success = false
        }
        
        return success
    }
    
    private func validateIATAField(iataText: String?) -> String? {
        guard let iataText = iataText, !iataText.isEmpty else {
            return Localizable.homeSearchRequiredFieldErrorMessage.localize()
        }
        if iataText.count != 3 {
            return Localizable.homeSearchInvalidIATACodeErrorMessage.localize()
        }
        return nil
    }

    private func validateDateField(dateText: String?) -> String? {
        guard let dateText = dateText, !dateText.isEmpty else {
            return Localizable.homeSearchRequiredFieldErrorMessage.localize()
        }
        guard dateText.toDate(format: .ddMMyyyy) != nil else {
            return Localizable.homeSearchInvalidDateFormatErrorMessage.localize()
        }
        return nil
    }
    
    private func validateNumberOfPassengersField(numberText: String?) -> String? {
        guard let numberText = numberText, !numberText.isEmpty else {
            return Localizable.homeSearchRequiredFieldErrorMessage.localize()
        }
        guard let value = Int(numberText) else {
            return Localizable.homeSearchInvalidNumberOfPassengersErrorMessage.localize()
        }
        guard case 1 ... 9 = value else {
            return Localizable.homeSearchInvalidNumberOfPassengersErrorMessage.localize()
        }
        return nil
    }
}
