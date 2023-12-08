//
//  WeatherManager.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/16/23.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

enum Environment {
    enum Keys {
    static let apiKey = "API_KEY"
    }
   
    static let infoDictionary: [String: Any] = {
       guard let dict = Bundle.main.infoDictionary else {
           fatalError("plist not found")
       }
       return dict
   }()
   
    static let apiKey: String = {
       guard let apiKeyString = Environment.infoDictionary[Keys.apiKey] as? String else {
           fatalError("API key not found")
       }
       return apiKeyString
   }()
    
}

struct WeatherManager {
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=\(Environment.apiKey)&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
  
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        //urlString passes to the performRequest(with:) function to fetch weather data for the specified location.
        performRequest(with: urlString)
    }
    
    //Networking -
    func performRequest(with urlString: String) {
        // 1. Create a URL - create an actual URL object
        //initialzing url with URL()
        if let url = URL(string: urlString) {
            // 2. Create a URLSession - the object thats going to be doing the networking
            //this creates the URL session object which is like the browser. Its the thing that can perfom the networking
            let session = URLSession(configuration: .default)
            
            // 3. Give a session a task - fetching the data from that particular source
            //this the completion handler - { data, response, error in ...
            let task = session.dataTask(with: url) { data, response, error in
                //check that error is not nill - means error occured
                if error != nil {
                    //error! - be able to check for errors
                    self.delegate?.didFailWithError(error: error!)
                    //if error return - exit out of func, do not continue
                    return
                }
                //if not errors - check what data got back
                // use optional binding to unwrap data object that got back
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task - when hit enter in the search bar which triggers the entire networking process and gets our data back.
            task.resume()
        }
    }
    //
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        //JSONDecoder - an object that can decode JSON
        let decoder = JSONDecoder()
        do {
            //decodedData has the data type of WeatherData, means has the property name, id, temp from the struct WeatherData
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            print(name)
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
