//
//  ViewController.swift
//  Weather App
//
//  Created by Mariola Hullings on 11/15/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionalImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nightBackgroundImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var localHour: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func getLocalTime(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error reverse geocoding location: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                if let timeZone = placemark.timeZone {
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = timeZone
                    dateFormatter.dateFormat = "HH"
                    let localHourString = dateFormatter.string(from: Date())
                    print("Local time for location: \(localHourString)")
                    if let localHour = Int(localHourString) {
                                        self.localHour = localHour
                        if (6...20).contains(localHour) {
                            self.backgroundImage.image = UIImage(named: "day")
                            dateFormatter.dateFormat = "h:mm a"
                            let localTime = dateFormatter.string(from: Date())
                            self.time.text = "Time: \(localTime)"
                            
                        } else {
                            self.backgroundImage.image = UIImage(named: "night")
                            dateFormatter.dateFormat = "h:mm a"
                            let localTime = dateFormatter.string(from: Date())
                            self.time.text = "Time: \(localTime)"
                        }
                    }
                    }
                }
            }
            
        }
        
    }


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
   
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(city) { (placemarks, error) in
                if let error = error {
                    print("Error geocoding city: \(error.localizedDescription)")
                    // Handle the error here if needed
                } else if let placemark = placemarks?.first {
                    let cityLatitude = placemark.location?.coordinate.latitude ?? 0.0
                    let cityLongitude = placemark.location?.coordinate.longitude ?? 0.0
                    
                    // Get the local time for the searched city
                    self.getLocalTime(latitude: cityLatitude, longitude: cityLongitude)

                    
                    
                }
            }
        }
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionalImageView.image = UIImage(systemName: weather.conditionName(localHour: self.localHour ?? 0))
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longtitude: lon)
            getLocalTime(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
