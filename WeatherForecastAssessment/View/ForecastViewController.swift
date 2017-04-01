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
        
        //        forecastPresenter = ForecasetPresenter(service: forecastService, view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData() {
        forecastPresenter.request()
    }
}

extension ForecastViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherHourlyData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHourlyCell", for: indexPath)
        let item = weatherHourlyData[indexPath.row]
        if let temperature = item.temperature {
            cell.textLabel?.text = WeatherData.toCelsius(temperature: temperature)
        }
        if let time = item.time {
            cell.detailTextLabel?.text = time.toDate()
        }
        return cell
    }
}

extension ForecastViewController: ForecastViewProtocol {
    
    // MARK: ForecastViewProtocol implementation
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
