//
//  MainScreenBuilder.swift
//  WeatherAppw
//
//  Created by Mert Karahan on 9.08.2022.
//

import Foundation
import UIKit


struct MainScreenBuilder {
    static func mainScreenStart() -> UIViewController? {
        
        var mainView : AnyMainScreenViewController = MainScreenViewController()
        var mainInteractor : AnyMainScreenInteractor = MainScreenInteractor()
        var mainPresenter : AnyMainScreenPresenter = MainScreenPresenter()
        
        mainView.interactor = mainInteractor
        mainInteractor.presenter = mainPresenter
        mainPresenter.mainScreenViewController = mainView
        
        return mainView as? UIViewController
    }
}
