//
//  WeatherModel.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/17/23.
//

import UIKit

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditonName: String {
        let hour = getCurrentHour()
        switch conditionID {
        case 200...211:
            return hourIsDaytime(hour) ? "cloud.bolt" : "cloud.moon.bolt"
        case 230...232:
            return hourIsDaytime(hour) ? "cloud.bolt.rain" : "cloud.moon.bolt.fill"
        case 300, 321:
            return hourIsDaytime(hour) ? "cloud.drizzle" : "cloud.moon.rain.fill"
        case 500...521:
            return hourIsDaytime(hour) ? "cloud.rain" : "cloud.moon.rain.fill"
        case 522...531:
            return hourIsDaytime(hour) ? "cloud.heavyrain" : "cloud.moon.rain"
        case 611...612:
            return hourIsDaytime(hour) ? "cloud.sleet" : "moon.dust.fill"
        case 600...602:
            return hourIsDaytime(hour) ? "cloud.snow" : "moon.dust.fill"
        case 615...622:
            return hourIsDaytime(hour) ? "cloud.snow" : "moon.dust.fill"
        case 701...771:
            return hourIsDaytime(hour) ? "cloud.fog" : "moon.haze"
        case 781:
            return "tornado"
        case 801...804:
            return hourIsDaytime(hour) ? "cloud" : "cloud.moon.fill"
        case 800:
            return hourIsDaytime(hour) ? "sun.max" : "moon.stars.fill"
        case 801:
            return hourIsDaytime(hour) ? "cloud.fill" : "cloud.moon.fill"
        default:
            return hourIsDaytime(hour) ? "cloud" : "cloud.moon.fill"
        }
    }
    
    func getCurrentHour() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        return calendar.component(.hour, from: currentDate)
    }

    func hourIsDaytime(_ hour: Int) -> Bool {
        return (6...20).contains(hour)
    }
}
