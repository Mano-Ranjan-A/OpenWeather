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
    @Published var errotType: ErrorType = .networkError
    
    var firstTimeLaunch = true
    var locationManager = LocationManager()
    private var networkManager = NetworkManager()
    
    
    private let openWeatherBaseURLString = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "bb74f9f6d729b0f7edab906e06539aad"
    
    init() {
        locationManager.setDelegate(delegate: self)
    }
    
    /// Method to call the location manager and retrive the users latest location and  update weather 
    func fetchWeather() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    /// Method to fetch weather data of users current location
    private func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
        
        guard let latitude = lat, let longitude = lon else {
            isLoading = false
            didErrorOccured = true
            errotType = .noLocationAccess
            return
        }
        
        let weatherUrlString = openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&cnt=5"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isLoading = await !callApi(weatherUrl, forcastUrl)
    }
    
    /// Method to call the weather API and always return true to indicate api call ended
    private func callApi(_ weatherUrl: URL, _ forcastUrl: URL) async -> Bool {
        
        guard networkManager.isNetworkAvailble else {
            didErrorOccured = true
            errotType = .networkError
            return true
        }
        
        async let weatherData = networkManager.getWeatherData(from: weatherUrl)
        async let forcastData = networkManager.getWeatherData(from: forcastUrl)
        
        guard let weatherData = await weatherData, let forcastData = await forcastData,
              let weather = try? JSONDecoder().decode(TodayWeatherModel.self, from: weatherData),
              let forcast = try? JSONDecoder().decode(ForcastWeatherModel.self, from: forcastData) else {
            isLoading = false
            didErrorOccured = true
            errotType = .apiError
            return true
        }
        todaysWeather = weather
        forcastWeather = forcast
        return true
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
