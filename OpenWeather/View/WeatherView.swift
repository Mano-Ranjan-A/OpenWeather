//
//  WeatherView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var networkManager: NetworkManager
    @EnvironmentObject var viewModel: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            //TODO: check the logic
            if networkManager.isNetworkAvailble && locationManager.isLocationAuthorised && locationManager.location == nil {
                // TODO: Call weather API
                if let todayWeather = viewModel.todaysWeather {
                    List {
                        TodayWeatherView(todayWeather: todayWeather, isLatestLocation: true, showLocationIco: true)
                        ForcastView(forcastList: WeatherViewModel.forcastPreviewData)
                            
                    }
                    .refreshable {
                        Task {
                            print(locationManager.location)
                            await viewModel.fetchWeatherDataFor(lat: 80.2785, //locationManager.location?.latitude,
                                                                lon: 13.0878) //locationManager.location?.longitude)
                        }
                    }
                } else {
                    ErrorView(errorType: .apiError)
                }
            } else if networkManager.isNetworkAvailble && (!locationManager.isLocationAuthorised || locationManager.location == nil) {
                ErrorView(errorType: .noLocationAccess)
                    .onAppear() {
                        Task {
                            print(locationManager.location)
                            await viewModel.fetchWeatherDataFor(lat: locationManager.location?.latitude,
                                                                lon: locationManager.location?.longitude)
                        }
                    }
            } else if !networkManager.isNetworkAvailble {
                ErrorView(errorType: .networkError)
            }
        }
        .onAppear() {
            Task {
                print(locationManager.location)
                await viewModel.fetchWeatherDataFor(lat: 44.34, //locationManager.location?.latitude,
                                                    lon: 10.99) //locationManager.location?.longitude)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(NetworkManager())
            .environmentObject(WeatherViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
