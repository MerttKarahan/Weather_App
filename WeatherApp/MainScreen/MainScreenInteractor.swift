//
//  MainScreenInteractor.swift
//  WeatherApp
//
//  Created by Mert Karahan on 28.07.2022.
//

import Foundation

protocol AnyMainScreenInteractor {
    var presenter: AnyMainScreenPresenter? {get set}
//    func fetchForecastResponseFromWorker(ltglon: Details)
    func fetchForecastResponseFromWorker(lat: Double, lng: Double)
}

class MainScreenInteractor : AnyMainScreenInteractor{
    
    var placeItemResponse : PlaceItemResponse?
    var weatherItemResponse : WeatherItemResponse?
    var presenter: AnyMainScreenPresenter?
    
    func fetchForecastResponseFromWorker(lat: Double, lng: Double) {
        ServiceManager.shared.getForecast(lat: Float(lat), lon: Float(lng)) { result in
            switch result {
            case.success(let forecastResponse):
                self.presenter?.forecast(resp: forecastResponse)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
