//
//  Worker.swift
//  WeatherApp
//
//  Created by Mert Karahan on 28.07.2022.
//

import Foundation
import Moya

typealias APIResult<T> = Result<T,MoyaError>

public final class ServiceManager {
    
    fileprivate let provider = MoyaProvider<ApiTypes>(plugins: [NetworkLoggerPlugin()])
    
    fileprivate var jsonDecoder = JSONDecoder()

    public static let shared = ServiceManager()

    fileprivate func fetch<M: Decodable>(target: ApiTypes,
                                         completion: @escaping (_ result: APIResult<M>) -> Void ) {
        provider.request(target) { (result) in

            switch result {
            case .success(let response):
                
                do {

                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    
                    let mappedResponse = try filteredResponse.map(M.self,
                                                                  atKeyPath: nil,
                                                                  using: self.jsonDecoder,
                                                                  failsOnEmptyData: false)
                    
                    completion(.success(mappedResponse))
                } catch MoyaError.statusCode(let response) {
                    completion(.failure(MoyaError.statusCode(response)))
                } catch {
                    debugPrint("##ERROR parsing##: \(error.localizedDescription)")
                    let moyaError = MoyaError.requestMapping(error.localizedDescription)
                    completion(.failure(moyaError))
                }
            case .failure(let error):
                debugPrint("##ERROR service:## \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func getPlaces(query: String,completion: @escaping (_ result: APIResult<PlaceItemResponse>) -> Void) {
        fetch(target: .getPlace(query: query), completion: completion)
    }
    
    func getForecast(lat: Float, lon: Float, completion: @escaping (_ result: APIResult<WeatherItemResponse>) -> Void) {
        fetch(target: .getWeather(latitude: lat, longitude: lon), completion: completion)
    
    }

}
