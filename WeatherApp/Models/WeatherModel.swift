//
//  MainScreenModel.swift
//  WeatherApp
//
//  Created by Mert Karahan on 27.07.2022.
//

import Foundation

struct WeatherItemResponse: Decodable {
    let cod : String
    let message : Int
    let cnt : Int
    let list : [WeatherListItem]
    let city : WeatherCityItem
}

struct WeatherCityItem : Decodable {
    let name : String
    let country : String
}

struct WeatherListItem : Decodable {
    let main : Main
    let wind : Wind
    let weather : [Weather]
    let dt_txt : String
}

struct Main : Decodable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
}

struct Weather: Decodable {
    let main : String
    let icon : String
    let description : String
}

struct Wind : Decodable {
    let speed : Double
}
