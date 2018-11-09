//
//  HomeSearchViewModelProtocol.swift
//  TravelApp
//
//  Created by Diego Lima on 07/09/18.
//  Copyright © 2018 Diego Lima. All rights reserved.
//

import Foundation

protocol HomeSearchViewModelProtocol {

    func validateForm(withForm model: HomeSearchFormModel)
    var searchFormState: Dynamic<HomeSearchFormViewStates?> { get set }
}
