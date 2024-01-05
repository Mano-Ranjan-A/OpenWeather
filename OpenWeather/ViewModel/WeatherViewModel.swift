//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation
import CoreLocation
import SwiftUI

protocol LocationManagerProtocol {
    func didUpdateLocation(location: CLLocationCoordinate2D?)
}

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    @Published var didErrorOccured = false
    @Published var isLoading = false
    @Published var errotType: ErrorType = .noError
    
    private let networkManager = NetworkManager()
    private let locationManager = LocationManager()
    
    var firstTimeLaunch = true
    
    init() {
        locationManager.delegate = self
    }
    
    /// Method to call the location manager and retrive the users latest location and  update weather 
    func fetchWeather() {
        locationManager.requestLocation()
    }
    
    /// Method to fetch weather data of users current location
    private func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
         isLoading = true
        
        guard let latitude = lat, let longitude = lon else {
            isLoading = false
            didErrorOccured = true
            errotType = .noLocationAccess
            return
        }
        
        let weatherUrlString = OpenWeatherConstants.openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(OpenWeatherConstants.apiKey)&units=metric"
        let forcastUrlString = OpenWeatherConstants.openWeatherBaseURLString + "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(OpenWeatherConstants.apiKey)&units=metric"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        (didErrorOccured, errotType, todaysWeather, forcastWeather) = await WeatherApiCaller().callApiWith(weatherUrl, and: forcastUrl, using: networkManager)
        isLoading = false
    }
}

// MARK: LocationManagerProtocol implementation
extension WeatherViewModel: LocationManagerProtocol {
    
    /// Method  to call the weather API as soon as location manager sends the current location
    func didUpdateLocation(location: CLLocationCoordinate2D?) {
        Task {
            await fetchWeatherDataFor(lat: location?.latitude, lon: location?.longitude)
        }
    }
    
    
}
