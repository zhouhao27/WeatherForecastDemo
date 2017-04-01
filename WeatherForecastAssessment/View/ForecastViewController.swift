//
//  ForecastViewController.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit

class ForecastViewController: UIViewController {
    
    var forecastPresenter: ForecasetPresenter!
    var lastErrorMessage = ""
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var weatherHourlyData = [WeatherHourlyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Weather Forecast"
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData() {
        forecastPresenter.request()
    }
}

// MARK: UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherHourlyData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCell", for: indexPath) as! HourlyDataViewCell
        let item = weatherHourlyData[indexPath.row]
        if let temperature = item.temperature {
            cell.labelTemperature.text = WeatherData.toCelsius(temperature: temperature)
        }
        if let time = item.time {
            cell.labelDate.text = time.toDate()
        }
        if let summary = item.summary {
            cell.labelSummary.text = summary
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

// MARK: ForecastViewProtocol
extension ForecastViewController: ForecastViewProtocol {
    
    func showLoading(_ loading: Bool) {
        if loading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        print(message)
        lastErrorMessage = message
    }
    
    func showWeatherData(_ data: WeatherData) {
        
        if let temperature = data.temperature {
            self.temperatureLabel.text = WeatherData.toCelsius(temperature: temperature)
        }
        
        if let humidity = data.humidity {
            self.humidityLabel.text = "Humidity: \(humidity)"
        }
        if let time = data.time {
            self.dateLabel.text = time.toDate()
        }
        
        if let summary = data.summary {
            self.summaryLabel.text = summary
        }
        
        if let all = data.data {
            weatherHourlyData = all
            tableView.reloadData()
        }
        
        lastErrorMessage = ""
    }
    
}
