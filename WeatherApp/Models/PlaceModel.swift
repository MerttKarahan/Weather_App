//
//  PlaceModel.swift
//  WeatherApp
//
//  Created by Mert Karahan on 28.07.2022.
//

import Foundation

struct PlaceItemResponse :Decodable {
    let hits : [PlaceItem]
}

struct PlaceItem : Decodable {
    let _geoloc : Details
    let administrative : [String]
    let county : Default?

}

struct Default : Decodable {
    let `default` : [String]
}

struct Details : Decodable {
    let lat : Double
    let lng : Double
}
