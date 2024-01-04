//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Mano on 02/01/24.
//

import Foundation

@MainActor
class PicALocViewModel: ObservableObject {
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    @Published var showSearchMessage = true
    @Published var didErrorOccured = false
    @Published var isLoading = false
    @Published var errotType: ErrorType = .noError
    
    let networkManager = NetworkManager()
    
    /// Method to fetch weather data of specified city
    func fetchWeatherDataFor(city: String) async {
        let weatherUrlString = OpenWeatherConstants.openWeatherBaseURLString + "weather?q=\(city)&appid=\(OpenWeatherConstants.apiKey)&units=metric"
        let forcastUrlString = OpenWeatherConstants.openWeatherBaseURLString + "forecast?q=\(city)&appid=\(OpenWeatherConstants.apiKey)&units=metric"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isLoading = true
        (didErrorOccured, errotType, todaysWeather, forcastWeather) = await WeatherApiCaller.callApiWith(weatherUrl, forcastUrl, using : networkManager)
        isLoading = false
        showSearchMessage = false
    }
}
