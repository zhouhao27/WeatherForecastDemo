//
//  ForecastService.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ForecastService: ForecastServiceProtocol {
    
    static let api = "https://api.forecast.io/forecast"
    static let key = "4b3125a395d59bcfb37c846398aabc63"
    
    func request(coordinate: CLLocationCoordinate2D) -> Promise<WeatherData> {
        
        let url = "\(ForecastService.api)/\(ForecastService.key)/\(coordinate.latitude),\(coordinate.longitude)?exclude=minutely,daily,alerts,flags"
        
        return Promise { fulfill, reject in
            Alamofire.request(url).responseObject { (response: DataResponse<WeatherData>) in
                if response.result.isSuccess {
                    if let weatherData = response.result.value {
                        fulfill(weatherData)
                    }
                } else {
                    let err = NSError(domain: "WeatherForcast", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request weather forcast data"])
                    reject(err)
                }
            }
        }
    }
}
