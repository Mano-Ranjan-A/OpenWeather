//
//  ContentView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherAppTabView: View {
    @State var reload = false
    var body: some View {
        NavigationView {
            TabView {
                WeatherView()
                    .tabItem {
                        Label("Weather", systemImage: "cloud.sun.fill")
                    }
                
                PicALocView()
                    .tabItem {
                        Label("Search", systemImage: "location.fill")
                }
            }
            .navigationTitle("Open Weather")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAppTabView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
