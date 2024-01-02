//
//  WeatherModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation


// MARK: - WeatherModel
struct TodayWeatherModel: Codable {
    let weather: [Weather]
    let temperature: Temperature
    let city: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case weather, cod
        case temperature = "main"
        case city = "name"
    }
}

// MARK: - ForcastWeatherModel
struct ForcastWeatherModel: Codable {
    let cod: String
    let list: [ForcastList]
    let city: City
}

// MARK: - ForcastList
struct ForcastList: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let temperature: Temperature
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, weather
        case temperature = "main"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let temp, feelsLike, tempMin, tempMax: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let description: String
}


// MARK: - City
struct City: Codable {
    let name: String
}


