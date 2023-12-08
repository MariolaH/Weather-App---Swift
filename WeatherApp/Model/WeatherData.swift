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
    //property name ie. temp has to match the property name in the JSON data
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

