//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created by Mert Karahan on 28.07.2022.
//

import Foundation

protocol AnyMainScreenPresenter {
    var mainScreenViewController: AnyMainScreenViewController? {get set}
    func forecast(resp: WeatherItemResponse)
}

class MainScreenPresenter: AnyMainScreenPresenter {
    
    var mainScreenViewController: AnyMainScreenViewController?
    
    func forecast(resp: WeatherItemResponse) {
        mainScreenViewController?.getResponseFromPresenter(response: resp)
    }
    
}
