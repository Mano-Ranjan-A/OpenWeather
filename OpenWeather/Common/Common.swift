//
//  Common.swift
//  OpenWeather
//
//  Created by Mano on 02/01/24.
//

import Foundation

public struct previewData {
    
    static let todayWeatherPreviewData = TodayWeatherModel(weather: [Weather(id: 200, description: "Cloudy")],
                                                           temperature: Temperature(temp: 38, feelsLike: 30, tempMin: 26, tempMax: 34),
                                                           city: "Chennai",
                                                           cod: 200)
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
