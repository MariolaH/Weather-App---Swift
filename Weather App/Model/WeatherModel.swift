//
//  WeatherModel.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/17/23.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditonName: String {
        switch conditionID {
        case 200...211:
            return "cloud.bolt"
        case 230...232:
            return "cloud.bolt.rain"
        case 300, 321:
            return "cloud.drizzle"
        case 500...521:
            return "cloud.rain"
        case 522...531:
            return "cloud.heavyrain"
        case 611...612:
            return "cloud.sleet"
        case 600...602:
            return "cloud.snow"
        case 615...622:
            return "cloud.snow"
        case 701...771:
            return "cloud.fog"
        case 781:
            return "tornado"
        case 801...804:
            return "cloud"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}
