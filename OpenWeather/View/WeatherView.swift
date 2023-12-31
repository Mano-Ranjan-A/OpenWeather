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
    @State var showWeatherView = false
    @State var isPresented = false
    var body: some View {
        VStack {
            if networkManager.isNetworkAvailble && locationManager.isLocationAuthorised {
                // TODO: Call weather API
                let apiSuccess = true
                if apiSuccess {
                    List {
                        TodayWeatherView(cityName: "Chennai", todaysDesc: "Mostly Cloudy today", isLatestLocation: true)
                        ForcastView(todaysDesc: "Mostly Cloudy")
                    }
                } else {
                    ErrorView(errorType: .apiError)
                }
            } else if networkManager.isNetworkAvailble && !locationManager.isLocationAuthorised {
                ErrorView(errorType: .noLocationAccess)
            } else if !networkManager.isNetworkAvailble {
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
