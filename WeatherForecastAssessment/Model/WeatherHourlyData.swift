//
//  WeatherHourlyData.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherHourlyData: Mappable {
    var summary: String?
    var temperature: Double?
    var time: Double?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        time <- map["time"]
        temperature <- map["temperature"]
        summary <- map["summary"]
    }
}
