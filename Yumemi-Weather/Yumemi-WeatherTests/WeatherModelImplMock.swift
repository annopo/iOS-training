//
//  WeatherModelMock.swift
//  Yumemi-WeatherTests
//
//  Created by anna.ishizaki on 2021/06/29.
//

import Foundation
@testable import Yumemi_Weather

class SunnyModelImplMock: WeatherModel {
    func getWeather(request: Request) -> WeatherInfo? {
        return WeatherInfo(maxTemp: 30, minTemp: 25, weather: "sunny")
    }
}

class CloudyModelImplMock: WeatherModel {
    func getWeather(request: Request) -> WeatherInfo? {
        return WeatherInfo(maxTemp: 25, minTemp: 20, weather: "cloudy")
    }
}

class RainyModelImplMock: WeatherModel {
    func getWeather(request: Request) -> WeatherInfo? {
        return WeatherInfo(maxTemp: 20, minTemp: 15, weather: "rainy")
    }
}
