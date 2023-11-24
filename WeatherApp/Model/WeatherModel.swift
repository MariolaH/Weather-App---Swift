//
//  WeatherModel.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/17/23.
//

import UIKit
import CoreLocation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
    
    func conditionName(localHour: Int) -> String {
        switch conditionID {
        case 200...211:
            return hourIsDaytime(localHour) ? "cloud.bolt" : "cloud.moon.bolt"
        case 230...232:
            return hourIsDaytime(localHour) ? "cloud.bolt.rain" : "cloud.moon.bolt.fill"
        case 300, 321:
            return hourIsDaytime(localHour) ? "cloud.drizzle" : "cloud.moon.rain.fill"
        case 500...521:
            return hourIsDaytime(localHour) ? "cloud.rain" : "cloud.moon.rain.fill"
        case 522...531:
            return hourIsDaytime(localHour) ? "cloud.heavyrain" : "cloud.moon.rain"
        case 611...612:
            return hourIsDaytime(localHour) ? "cloud.sleet" : "moon.dust.fill"
        case 600...602:
            return hourIsDaytime(localHour) ? "cloud.snow" : "moon.dust.fill"
        case 615...622:
            return hourIsDaytime(localHour) ? "cloud.snow" : "moon.dust.fill"
        case 701...771:
            return hourIsDaytime(localHour) ? "cloud.fog" : "moon.haze"
        case 781:
            return "tornado"
        case 801...804:
            return hourIsDaytime(localHour) ? "cloud" : "cloud.moon.fill"
        case 800:
            return hourIsDaytime(localHour) ? "sun.max" : "moon.stars.fill"
        case 801:
            return hourIsDaytime(localHour) ? "cloud.fill" : "cloud.moon.fill"
        default:
            return hourIsDaytime(localHour) ? "cloud" : "cloud.moon.fill"
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
