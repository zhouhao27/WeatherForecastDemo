//
//  ForecastPresenterTests.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import XCTest
import CoreLocation
import PromiseKit

@testable import WeatherForecastAssessment

class ForecastPresenterTests: XCTestCase {
    
    class MockForecastView: ForecastViewProtocol {
        
        var showWeatherDataCalled = false
        var showErrorCalled = false
        
        func showLoading(_ loading: Bool) {
            
        }
        
        func showError(_ message: String) {
            showErrorCalled = true
        }
        
        func showWeatherData(_ data: WeatherData) {
            showWeatherDataCalled = true
        }
    }
    
    class MockSuccessService: ForecastServiceProtocol {
        func request(coordinate: CLLocationCoordinate2D) -> Promise<WeatherData> {
            return Promise { fulfill, reject in
                let data = WeatherData(JSONString:"{\"currently\":{\"summary\":\"Test\"}}")
                fulfill(data!)
            }
        }
    }
    
    class MockFailureService: ForecastServiceProtocol {
        func request(coordinate: CLLocationCoordinate2D) -> Promise<WeatherData> {
            return Promise { fulfill, reject in
                let err = NSError(domain: "WeatherForcastTest", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to request weather forcast data"])
                reject(err)
            }
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessRequest() {
        let service = MockSuccessService()
        let view = MockForecastView()
        
        let forecastPresenter = ForecasetPresenter(service: service, view: view)
        forecastPresenter.request()
        wait(for: 1)
        XCTAssert(view.showWeatherDataCalled)
        XCTAssert(!view.showErrorCalled)
    }
    
    func testFailureRequest() {
        let service = MockFailureService()
        let view = MockForecastView()
        
        let forecastPresenter = ForecasetPresenter(service: service, view: view)
        forecastPresenter.request()
        wait(for: 1)
        XCTAssert(!view.showWeatherDataCalled)
        XCTAssert(view.showErrorCalled)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
