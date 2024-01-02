//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation
import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    
    @StateObject var locationManager = LocationManager()
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    @Published var didErrorOccured = false
    @Published var isLoading = false
    @Published var errotType: ErrorType = .networkError
    
    var firstTimeLaunch = true
    private var networkManager = NetworkManager()
    private let openWeatherBaseURLString = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "bb74f9f6d729b0f7edab906e06539aad"
    
   
    /// Method to fetch weather data of users current location
    func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
        guard let latitude = lat, let longitude = lon else {
            didErrorOccured = true
            errotType = .noLocationAccess
            return
        }
        
        let weatherUrlString = openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&cnt=5"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isLoading = true
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
            didErrorOccured = true
            errotType = .apiError
            return true
        }
        todaysWeather = weather
        forcastWeather = forcast
        return true
    }
}
