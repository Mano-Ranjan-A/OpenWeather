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
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    @Published var isCurrentLocWeatherLoading = false
    @Published var isSearchLocWeatherLoading = false
    @Published var didErrorOccured = false
    @Published var errotType: ErrorType = .networkError
    
    private var networkManager = NetworkManager()
    private let openWeatherBaseURLString = "https://api.openweathermap.org/data/2.5/"
    private let apiKey = "bb74f9f6d729b0f7edab906e06539aad"
    
    static let todayWeatherPreviewData = TodayWeatherModel(weather: [Weather(id: 200, description: "Cloudy")],
                                                           temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34),
                                                           city: "Chennai",
                                                           cod: 200)
    static let forcastPreviewData = [
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "cloud")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "sunny")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "rainy")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "strom")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "cloud")], dtTxt: "22.5.23")
    ]
}

// MARK: - API Call methods
extension WeatherViewModel {
    
    /// Method to fetch weather data of users current location
    func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
        guard let latitude = lat, let longitude = lon else { return }
        let weatherUrlString = openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isCurrentLocWeatherLoading = true
        isCurrentLocWeatherLoading = await callApi(weatherUrl, forcastUrl)
    }
    
    /// Method to fetch weather data of specified city
    func fetchWeatherDataFor(city: String) async {
        let weatherUrlString = openWeatherBaseURLString + "weather?q=\(city)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?q=\(city)&appid=\(apiKey)&units=metric&cnt=5"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isSearchLocWeatherLoading = true
        isSearchLocWeatherLoading = await !callApi(weatherUrl, forcastUrl)
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


// MARK: Extension of Double data type
extension Double {
    
    /// Method to convert double as single point precision and return as string
    ///  - eg: input = 3.45643 output will be "3.4"
    func limitToSingleDigitPrecision() -> String {
        let nf = NumberFormatter()
        nf.roundingMode = .down
        nf.maximumFractionDigits = 1
        return nf.string(for: self) ?? ""
    }
}
