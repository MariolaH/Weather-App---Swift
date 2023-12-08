//
//  WeatherModel.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/17/23.
//

import UIKit
import CoreLocation

struct WeatherModel {
    //these properties are stored properties, because all they do is store pieces of data
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    //computed property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    func conditionName(localHour: Int) -> String {
        switch conditionID {
        case 200...211:
            return hourIsDaytime(localHour) ? "cloud.bolt" : "cloud.moon.bolt"
        case 230...232:
            return hourIsDaytime(localHour) ? "cloud.bolt.rain" : "cloud.moon.bolt"
        case 300, 321:
            return hourIsDaytime(localHour) ? "cloud.drizzle" : "cloud.moon.rain"
        case 500...521:
            return hourIsDaytime(localHour) ? "cloud.rain" : "cloud.moon.rain"
        case 522...531:
            return hourIsDaytime(localHour) ? "cloud.heavyrain" : "cloud.moon.rain"
        case 611...612:
            return hourIsDaytime(localHour) ? "cloud.sleet" : "moon.dust"
        case 600...602:
            return hourIsDaytime(localHour) ? "cloud.snow" : "moon.dust"
        case 615...622:
            return hourIsDaytime(localHour) ? "cloud.snow" : "moon.dust"
        case 701...771:
            return hourIsDaytime(localHour) ? "cloud.fog" : "moon.haze"
        case 781:
            return "tornado"
        case 801...804:
            return hourIsDaytime(localHour) ? "cloud" : "cloud.moon"
        case 800:
            return hourIsDaytime(localHour) ? "sun.max" : "moon.stars"
        case 801:
            return hourIsDaytime(localHour) ? "cloud.fill" : "cloud.moon"
        default:
            return hourIsDaytime(localHour) ? "cloud" : "cloud.moon"
        }
    }
    
//    func getCurrentHour() -> Int {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        return calendar.component(.hour, from: currentDate)
//    }

    func hourIsDaytime(_ localHour: Int) -> Bool {
        return (6...20).contains(localHour)
    }
}
