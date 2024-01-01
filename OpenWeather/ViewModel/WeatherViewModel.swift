//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    @Published var isLoading = false
    @Published var errorOccured = false
    
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
    
    func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
        guard let latitude = lat, let longitude = lon else { return }
        let weatherUrlString = openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isLoading = true
        isLoading = await callApi(weatherUrl, forcastUrl)
    }
    
    func fetchWeatherDataFor(city: String) async {
        let weatherUrlString = openWeatherBaseURLString + "weather?q=\(city)&appid=\(apiKey)&units=metric"
        let forcastUrlString = openWeatherBaseURLString + "forecast?q=\(city)&appid=\(apiKey)&units=metric&cnt=5"
        guard let weatherUrl = URL(string: weatherUrlString), let forcastUrl = URL(string: forcastUrlString) else { return }
        
        isLoading = true
        isLoading = await callApi(weatherUrl, forcastUrl)
    }
    
    func callApi(_ weatherUrl: URL, _ forcastUrl: URL) async -> Bool {
        async let weatherData = NetworkManager.getWeatherData(from: weatherUrl)
        async let forcastData = NetworkManager.getWeatherData(from: forcastUrl)
        
        guard let weatherData = await weatherData, let forcastData = await forcastData,
              let weather = try? JSONDecoder().decode(TodayWeatherModel.self, from: weatherData),
              let forcast = try? JSONDecoder().decode(ForcastWeatherModel.self, from: forcastData) else {
            self.errorOccured = true
            return false
        }
        todaysWeather = weather
        forcastWeather = forcast
        return false
    }
    
    func getWeatherIcoName(for weatherId: Int?) -> String {
        guard let id = weatherId else {
            return "xmark.iclouf.fill"
        }
        switch id {
        case 200..<235:
            return "cloud.bolt.rain.fill"
        case 300..<325:
            return "cloud.sun.rain.fill"
        case 500..<535:
            return "cloud.heavyrainfall.fill"
        case 600..<625:
            return "snow"
        case 700..<800:
            return "cloud.fog.fill"
        case 801, 802:
            return "cloud.sun.fill"
        case 803, 804:
            return "smoke.fill"
        case 800:
            return "sun.max.fill"
        default:
            return "xmark.iclouf.fill"
        }
    }
}

extension Double {
    func limitToSingleDigitPrecision() -> String {
        let nf = NumberFormatter()
        nf.roundingMode = .down
        nf.maximumFractionDigits = 1
        return nf.string(for: self) ?? ""
    }
}
