//
//  WeatherAPICaller.swift
//  OpenWeather
//
//  Created by Mano on 04/01/24.
//

import Foundation

class WeatherApiCaller {
    
    /// Method to call the weather API and always return true to indicate api call ended
    ///  - returns (didErrorOccur, errorType, todayWeather, forcastWeather)
    func callApiWith(_ weatherUrl: URL, and forcastUrl: URL, using networkManager: NetworkManager) async -> (Bool, ErrorType, TodayWeatherModel?, ForcastWeatherModel?) {
        
        guard networkManager.isNetworkAvailble else {
            return (true, .networkError, nil, nil)
        }
        
        async let weatherData = networkManager.getWeatherData(from: weatherUrl)
        async let forcastData = networkManager.getWeatherData(from: forcastUrl)
        
        guard let weatherData = await weatherData, let forcastData = await forcastData,
              let weather = try? JSONDecoder().decode(TodayWeatherModel.self, from: weatherData),
              let forcast = try? JSONDecoder().decode(ForcastWeatherModel.self, from: forcastData) else {
            return (true, .apiError, nil, nil)
        }
        
        guard forcast.cod != "404" else {
            var errType: ErrorType = .apiError
            if forcast.message?.caseInsensitiveCompare(OpenWeatherConstants.cityNotFound) == .orderedSame {
                errType = .locationNotAvailable
            }
            return (true, errType, nil, nil)
        }
        
        return (false, .noError, weather, filterForcastData(forcastData: forcast))
    }
    
    /// Method to filter out the 3 hour weather data and return forcast model containind only one forcast for each day
    private func filterForcastData(forcastData: ForcastWeatherModel) -> ForcastWeatherModel? {
        guard var forcastList = forcastData.list else { return nil }
        var filteredForcastList = [ForcastList]()
        
        for i in 0..<(forcastList.count - 1) {
            let date1 = Date(timeIntervalSince1970: Double(forcastList[i].dt))
            let date2 = Date(timeIntervalSince1970: Double(forcastList[i+1].dt))
            if Calendar.current.isDate(date1, equalTo: date2, toGranularity: .day) {
                continue
            } else {
                filteredForcastList.append(forcastList[i])
            }
        }
        
        return ForcastWeatherModel(list: filteredForcastList,
                                   city: forcastData.city,
                                   cod: forcastData.cod,
                                   message: forcastData.message)
    }
}
