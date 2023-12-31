//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var todaysWeather: TodayWeatherModel?
    @Published var forcastWeather: ForcastWeatherModel?
    
    static let testData = TodayWeatherModel(weather: [Weather(id: 20, description: "Cloudy")],
                                     temperature: Temterature(avgTemp: 28,
                                                              minTemp: 26,
                                                              maxTemp: 32,
                                                              feelLike: 30),
                                     cityName: "Chenni")
    func fetchWeatherDataFor(lat: String, long: String) {
        // TODO: Call API
    }
    
    func fetchWeatherDataFor(city: String) {
//         TODO: Call API
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
