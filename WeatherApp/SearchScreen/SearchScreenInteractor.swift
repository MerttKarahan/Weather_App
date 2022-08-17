//
//  SearchScreenInteractor.swift
//  WeatherApp
//
//  Created by Mert Karahan on 3.08.2022.
//

import Foundation

protocol AnySearchScreenInteractor {
    var searchPresenter: AnySearchScreenPresenter? {get set}
    func fetchPlaceResponseFromWorker(text: String)
}

class SearchScreenInteractor: AnySearchScreenInteractor {
    
    var placeItem: PlaceItemResponse?
    var searchPresenter: AnySearchScreenPresenter?
    
    func fetchPlaceResponseFromWorker(text: String) {
        ServiceManager.shared.getPlaces(query: text) { result in
            switch result {
            case.success(let response):
                self.placeItem? = response
                self.searchPresenter?.getResponseFromInteractor(resp: response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
