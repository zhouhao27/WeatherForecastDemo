//
//  WeatherDataTests.swift
//  WeatherForecastAssessment
//
//  Created by Zhou Hao on 1/4/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import XCTest
@testable import WeatherForecastAssessment

class WeatherDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfulParsing() {
        let data = WeatherData(JSONString:"{\"currently\":{\"summary\":\"Test\"}}")
        XCTAssert(data!.summary == "Test")
    }
    
    func testFailedParsing() {
        let data = WeatherData(JSONString:"{\"currently\":{\"summary\":\"Test1\"}}")
        XCTAssert(data!.summary != "Test")
    }
    
}
