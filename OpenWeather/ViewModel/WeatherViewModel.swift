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
    
    let openWeatherBaseURLString = "api.openweathermap.org/data/2.5/"
    private let apiKey = "bb74f9f6d729b0f7edab906e06539aad"
    
    static let todayWeatherPreviewData = TodayWeatherModel(weather: [Weather(id: 200, description: "Cloudy")],
                                            temperature: Temterature(avgTemp: 28,
                                                                     minTemp: 26,
                                                                     maxTemp: 32,
                                                                     feelLike: 30),
                                            cityName: "Chennai")
    static let forcastPreviewData = [
        ForcastList(dt: 4567, temperature: Temterature(avgTemp: 38, minTemp: 36, maxTemp: 40, feelLike: 39), weather: [Weather(id: 320, description: "cloud")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temterature(avgTemp: 38, minTemp: 36, maxTemp: 40, feelLike: 39), weather: [Weather(id: 320, description: "sunny")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temterature(avgTemp: 38, minTemp: 36, maxTemp: 40, feelLike: 39), weather: [Weather(id: 320, description: "rainy")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temterature(avgTemp: 38, minTemp: 36, maxTemp: 40, feelLike: 39), weather: [Weather(id: 320, description: "strom")], dtTxt: "22.5.23"),
        ForcastList(dt: 4567, temperature: Temterature(avgTemp: 38, minTemp: 36, maxTemp: 40, feelLike: 39), weather: [Weather(id: 320, description: "cloud")], dtTxt: "22.5.23")
    ]
}

// MARK: - API Call methods
extension WeatherViewModel {
    
    func fetchWeatherDataFor(lat: Double?, lon: Double?) async {
        guard let latitude = lat, let longitude = lon else { return }
        let finalUrlString = openWeatherBaseURLString + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        guard let url = URL(string: finalUrlString) else { return }
        guard let weatherData: TodayWeatherModel = await NetworkManager.getWeatherData(from: url) else { return }
        self.todaysWeather = weatherData
    }
    
    func fetchWeatherDataFor(city: String) async {
        let finalUrlString = openWeatherBaseURLString + "forecast?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: finalUrlString) else { return }
        guard let forcastData: ForcastWeatherModel = await NetworkManager.getWeatherData(from: url) else { return }
        self.forcastWeather = forcastData
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
