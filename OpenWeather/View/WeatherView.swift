//
//  WeatherView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var networkManager: NetworkManager
    @StateObject var locationManager = LocationManager()
    @Binding var reload: Bool
    @State var showWeatherView: Bool = true
    @State var isPresented = false
    var body: some View {
        VStack {
            if showWeatherView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        TodayWeatherView(cityName: "Chennai", todaysDesc: "Mostly Cloudy today")
                        ForcastView(todaysDesc: "Mostly Cloudy")
                    }
                }
            }
            else {
                ErrorView(errorType: .networkError)
            }
        }
        .onChange(of: reload, perform: { _ in
            if isPresented {
                print("hi")
                showWeatherView.toggle()
            }
        })
        .onAppear() {
            if !networkManager.isNetworkAvailble {
                showWeatherView = false
            }
            locationManager.requestLocation()
            self.isPresented = true
        }
        .onDisappear() {
            self.isPresented = false
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(reload: .constant(true))
            .environmentObject(NetworkManager())
    }
}
