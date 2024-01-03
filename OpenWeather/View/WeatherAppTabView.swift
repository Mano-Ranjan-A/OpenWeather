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
        .onAppear {
            // code to fix the transperrency issue in swift UI tab bar
            let tabBarAppearence = UITabBarAppearance()
            tabBarAppearence.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearence
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAppTabView()
    }
}
