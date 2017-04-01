//
//  Double+Time.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import Foundation

extension Double {
    
    func toDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
    
    func toTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}
