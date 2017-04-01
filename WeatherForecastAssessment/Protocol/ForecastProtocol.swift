//
//  ForecastProtocol.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import PromiseKit
import CoreLocation

protocol ForecastViewProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(_ message: String)
    func showWeatherData(_ data: WeatherData)
}

protocol ForecastPresenterProtocol: class {
    func request()
}

protocol ForecastServiceProtocol: class {
    func request(coordinate: CLLocationCoordinate2D) -> Promise<WeatherData>
}
