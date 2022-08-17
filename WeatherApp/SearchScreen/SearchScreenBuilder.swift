//
//  SearchScreenBuilder.swift
//  WeatherApp
//
//  Created by Mert Karahan on 8.08.2022.
//

import Foundation
import UIKit

struct Builder {
    
    static func start() -> SearchScreenViewController? {
        
        var view: AnySearchScreenView = SearchScreenViewController()
        var presenter: AnySearchScreenPresenter = SearchScreenPresenter()
        var interactor: AnySearchScreenInteractor = SearchScreenInteractor()
        
        view.searchInteractor = interactor
        presenter.searchScreenView = view
        interactor.searchPresenter = presenter
        
        return view as? SearchScreenViewController
    }
}
