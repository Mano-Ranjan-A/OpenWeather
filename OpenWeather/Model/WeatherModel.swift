//
//  WeatherModel.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation


// MARK: - WeatherModel
struct TodayWeatherModel: Codable {
    let weather: [Weather]?
    let temperature: Temperature?
    let city: String?
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temperature = "main"
        case city = "name"
    }
}

// MARK: - ForcastWeatherModel
struct ForcastWeatherModel: Codable {
    let list: [ForcastList]?
    let city: City?
    let cod: String?
    let message: String?
    
    init(list: [ForcastList]?, city: City?, cod: String?, message: String?) {
        self.list = list
        self.city = city
        self.cod = cod
        self.message = message
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.list = try? container.decodeIfPresent([ForcastList].self, forKey: .list)
        self.city = try? container.decodeIfPresent(City.self, forKey: .city)
        self.cod = try? container.decodeIfPresent(String.self, forKey: .cod)
        if let msg = try? container.decodeIfPresent(Int.self, forKey: .message) {
            self.message = String(msg)
        } else {
            self.message = try container.decodeIfPresent(String.self, forKey: .message)
        }
    }
    
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


