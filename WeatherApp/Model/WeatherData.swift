//
//  weatherData.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/17/23.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

