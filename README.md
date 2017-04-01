# WeatherForecastAssessment

A MVP application which retreive forecast data from https://api.forecast.io/forecast.

> Url: "https://api.forecast.io/forecast/{Your API key here}/{latitude}, {longitude}"

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

Test the parsing function.

- View Controller (View) 

With some extra efforts, view controller is also testable. Since there are not much UI interactions so that I don't need UI unit testing.



