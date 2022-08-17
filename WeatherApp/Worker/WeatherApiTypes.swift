//
//  WeatherApiTypes.swift
//  WeatherApp
//
//  Created by Mert Karahan on 28.07.2022.
//

import Foundation
import Moya

enum ApiTypes {
    case getPlace (query: String)
    case getWeather (latitude: Float, longitude: Float)
}

extension ApiTypes: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getPlace:
            return URL(string : "https://places-dsn.algolia.net/1")!
            
        case .getWeather:
            return URL(string: "https://api.openweathermap.org/data/2.5")!
        }
    }
    
    var path: String {
        switch self {
        case .getPlace:
            return "/places/query"
            
        case.getWeather:
            return "/forecast"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case.getPlace(let query) :
            return .requestParameters(
                parameters: [
                    "query": query ,
                    "type" : "city" ],
                encoding: URLEncoding.default)
            
        case .getWeather(let latitude, let longitude):
            return .requestParameters(
                parameters: [
                    "lat" : latitude.description,
                    "lon" : longitude.description,
                    "appid" : "dc61d00cf0aa45160f9edd4409862220",
                    "units" : "metric"],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
