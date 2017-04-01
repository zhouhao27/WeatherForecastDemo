//
//  WeatherData.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherData: Mappable {
    
    static let keyApparentTemperature = "currently.apparentTemperature"
    static let keyCloudCover = "currently.cloudCover"
    static let keyDewPoint = "currently.dewPoint"
    static let keyIcon = "currently.icon"
    static let keyTemperature = "currently.temperature"
    static let keySummary = "currently.summary"
    static let keyHourlyData = "hourly.data"
    static let keyTime = "currently.time"
    static let keyHumidity = "currently.humidity"
    static let keyPressure = "currently.pressure"
    
    var apparentTemperature: Double?
    var cloudCover: Double?
    var dewPoint: Double?
    var icon: String?
    var time: Double?
    var humidity: Double?
    var temperature: Double?
    var summary: String?
    var pressure: Double?
    
    var data: [WeatherHourlyData]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        apparentTemperature <- map[WeatherData.keyApparentTemperature]
        cloudCover <- map[WeatherData.keyCloudCover]
        dewPoint <- map[WeatherData.keyDewPoint]
        icon <- map[WeatherData.keyIcon]
        time <- map[WeatherData.keyTime]
        temperature <- map[WeatherData.keyTemperature]
        humidity <- map[WeatherData.keyHumidity]
        summary <- map[WeatherData.keySummary]
        pressure <- map[WeatherData.keyPressure]
        data <- map[WeatherData.keyHourlyData]
    }
    
    static func toCelsius(temperature: Double) -> String {
        let t = String(format: "%.1f", (temperature - 32.0) * 5.0 / 9.0)
        return "\(t) °C"
    }
}
