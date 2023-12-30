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
    let temperature: Temterature
    let cityName: String
    
    enum CoadingKeys: String, CodingKey {
        case weather = "weather"
        case temperature = "main"
        case cityName = "name"
    }
}

// MARK: - ForcastWeatherModel
struct ForcastWeatherModel: Codable {
    let forcastList: [ForcastList]
    let locationData: LocationData
    
    enum CodingKeys: String, CodingKey {
        case forcastList = "list"
        case locationData = "city"
    }
}

// MARK: - ForcastList
struct ForcastList: Codable {
    let dt: Int
    let temperature: Temterature
    let weather: [Weather]
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, weather
        case temperature = "main"
        case dtTxt = "dt_txt"
    }
}

// MARK: - Temterature
struct Temterature: Codable {
    let avgTemp: Double
    
    enum CoadingKeys: String, CodingKey {
        case avgTemp = "temp"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let description: String
}


// MARK: - LocationData
struct LocationData: Codable {
    let cityName: String
    
    enum CoadingKeys: String, CodingKey {
        case cityName = "name"
    }
}


