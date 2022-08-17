//
//  SearchScreenPresenter.swift
//  WeatherApp
//
//  Created by Mert Karahan on 3.08.2022.
//

import Foundation

protocol AnySearchScreenPresenter {
    var searchScreenView: AnySearchScreenView? {get set}
    func getResponseFromInteractor(resp: PlaceItemResponse)
}

class SearchScreenPresenter: AnySearchScreenPresenter {
        
    var searchScreenView: AnySearchScreenView?
    var placeResponse : PlaceItemResponse?
    
    
    func getResponseFromInteractor(resp: PlaceItemResponse) {
        self.searchScreenView?.getResponseFromPresenter(response: resp)
    }
}
