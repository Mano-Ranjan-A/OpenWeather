//
//  OpenWeatherApp.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

@main
struct OpenWeatherApp: App {
    
    @StateObject var networkManager = NetworkManager()
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            WeatherAppTabView()
                .environmentObject(networkManager)
                .environmentObject(viewModel)
        }
    }
}
