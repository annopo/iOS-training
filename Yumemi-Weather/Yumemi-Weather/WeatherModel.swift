//
//  WeatherModel.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/06/09.
//
import UIKit
import Foundation
import YumemiWeather

protocol WeatherModel {
    func getWeather(request: Request) throws -> WeatherInfo?
}

class WeatherModelImpl: WeatherModel {
    
    func encodeRequest(from request: Request) throws -> String {
        let encoder = JSONEncoder()
        
        guard let requestData = try? encoder.encode(request) else {
            throw YumemiWeatherError.unknownError
        }
        let requestJsonString = String(bytes: requestData, encoding: .utf8)!
        return requestJsonString
    }
    
    func getWeather(request: Request) throws -> WeatherInfo? {
        guard let jsonString = try? YumemiWeather.fetchWeather(encodeRequest(from: request)),
              let jsonData = jsonString.data(using: .utf8),
              let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: jsonData) else {
            throw YumemiWeatherError.unknownError
        }
        return weatherInfo
    }

}
