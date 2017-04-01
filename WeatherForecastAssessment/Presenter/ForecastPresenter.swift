//
//  ForecastPresenter.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit

class ForecasetPresenter: ForecastPresenterProtocol {
    
    unowned fileprivate let service: ForecastServiceProtocol
    unowned fileprivate var view: ForecastViewProtocol
    
    required init(service: ForecastServiceProtocol, view: ForecastViewProtocol) {
        self.service = service
        self.view = view
    }
    
    func request() {
        // request location
        view.showLoading(true)
        firstly {
            CLLocationManager.promise()
            
            }.then { location in
                
                self.service.request(coordinate: location.coordinate)
                    .then { data in
                        self.view.showWeatherData(data)
                }
                
            }.always {
                self.view.showLoading(false)
            }.catch { error in
                print(error.localizedDescription)
                self.view.showError(error.localizedDescription)
        }
    }
    
}
