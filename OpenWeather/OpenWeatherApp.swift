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
    var body: some Scene {
        WindowGroup {
            WeatherAppTabView()
                .environmentObject(networkManager)
        }
    }
}
