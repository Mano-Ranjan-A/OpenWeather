//
//  Common.swift
//  OpenWeather
//
//  Created by Mano on 02/01/24.
//

import Foundation

public struct OpenWeatherConstants {
    
    static let apiKey = "bb74f9f6d729b0f7edab906e06539aad"
    static let openWeatherBaseURLString = "https://api.openweathermap.org/data/2.5/"
    
    static let searchMsg = "Want to feel how weather is like in other parts of the world. Search the city to see whats it like there."
    static let forcastMsg = "Weather forecast for next 5 days"
    static let todaysWeather = "Today's weather"
    static let cityNotFound = "city not found"
    static let enterCity = "Enter city name"
}

public struct previewData {
    
    static let todayWeatherPreviewData = TodayWeatherModel(weather: [Weather(id: 200, description: "Cloudy")],
                                                           temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34),
                                                           city: "Chennai")
    static let forcastPreviewData = [
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "cloud")]),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "Heavy rain")]),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "very heavy rain")]),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "strom")]),
        ForcastList(dt: 4567, temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34), weather: [Weather(id: 320, description: "cloud")])
    ]
}

extension String {
    var capitalizeFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}

extension Double {
    var roundToInt: Int {
        return Int(self.rounded())
    }
}
