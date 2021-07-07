//
//  WeatherInfo.swift
//  Yumemi-Weather
//
//  Created by anna.ishizaki on 2021/06/09.
//

import Foundation

struct WeatherInfo: Codable {
    let maxTemp: Int
    let minTemp: Int
    let weather: String
    
    enum CodingKeys: String, CodingKey {
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case weather
    }
}
