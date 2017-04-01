//
//  WeatherForecastAssessmentTests.swift
//  WeatherForecastAssessmentTests
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import XCTest
import PromiseKit
import ObjectMapper

@testable import WeatherForecastAssessment

class WeatherForecastAssessmentTests: XCTestCase {
    
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
    
    var viewController: ForecastViewController!
    var successPresenter: ForecasetPresenter!
    var failurePresenter: ForecasetPresenter!
    var mockSuccessService: MockSuccessService!
    var mockFailureService: MockFailureService!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = (storyboard.instantiateInitialViewController() as! UINavigationController).topViewController as! ForecastViewController
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessRequest() {
        mockSuccessService = MockSuccessService()
        successPresenter = ForecasetPresenter(service: mockSuccessService, view: viewController)
        viewController.forecastPresenter = successPresenter
        let _ = viewController.view
        viewController.viewDidAppear(false)
        wait(for: 1)
        XCTAssert(viewController.summaryLabel.text == "Test", "ForecastView's summary text not updated correctly")
    }
    
    func testFailureRequest() {
        mockFailureService = MockFailureService()
        failurePresenter = ForecasetPresenter(service: mockFailureService, view: viewController)
        viewController.forecastPresenter = failurePresenter
        let _ = viewController.view
        viewController.viewDidAppear(false)
        wait(for: 1)
        XCTAssert(viewController.lastErrorMessage == "Failed to request weather forcast data", "Error message not updated when failed to request from service")
    }
}
