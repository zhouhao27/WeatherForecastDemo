# WeatherForecastAssessment

A MVP application which retreive forecast data from https://api.forecast.io/forecast.

> Url: `https://api.forecast.io/forecast/{Your API key here}/{latitude}, {longitude}`

## Develop Environment

- Mac OSX 10.12.4
- Xcode 8.3
- iOS 9.0 and above
- Swift 3

In order to run the app in real device, need to select correct Team in **General** tab for the **WeatherForecastAssessment** target.

## Installation

> git clone  
> cd WeatherForecast  
> pod install  

## Dependency

- PromiseKit

Can also consider to use RxSwift, ReactiveCocoa for functional programming.

- Alamofire

Library for networking in Swift. Able to implement the networking function in URLSession. DispatchQueue.main.async is not needed because Response handlers by default are executed on the main dispatch queue.

- AlamofireObjectMapper

To map the json object to Swift object. We can also use responseJson of Alamofire to get Dictionary data to create the Swift object. And we can also use JSONSerialization to parse the json data if we're using URLSession to get data.

## Unit Testing

- Presenter

I'm using MVP instead of MVC so that most business logic are moved into Presenter. Presenter is the first thing I need to test. I can pass the Mock service as injected dependency to presenter to make the testing easier.

- Model

Test the Json data parse function (actually this is automatically done by ObjectMapper).

- View Controller (View) 

With some extra efforts, view controller is also testable. 


