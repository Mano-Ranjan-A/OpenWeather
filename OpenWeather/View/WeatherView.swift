//
//  WeatherView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            //TODO: check the logic
            if locationManager.isLocationAuthorised && locationManager.location != nil {
                // TODO: Call weather API
                if let todayWeather = viewModel.todaysWeather {
                    List {
                        let (ico, color) = viewModel.getWeatherIcoAndColorName(for: todayWeather.weather.first?.id)
                        TodayWeatherView(todayWeather: todayWeather,
                                         isLatestLocation: true,
                                         showLocationIco: true,
                                         weatherIco: ico,
                                         weatherColor: color)
                        ForcastView(forcastList: WeatherViewModel.forcastPreviewData,
                                    weatherIco: "cloud.fill",
                                    weatherColor: .blue)
                            
                    }
                } else {
                    ErrorView(errorType: .apiError)
                }
            } else if (!locationManager.isLocationAuthorised || locationManager.location == nil) {
                ErrorView(errorType: .noLocationAccess)
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchWeatherDataFor(lat: 80.2785, //locationManager.location?.latitude,
                                                    lon: 13.0878) //locationManager.location?.longitude)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeatherDataFor(lat: 44.34, //locationManager.location?.latitude,
                                                    lon: 10.99) //locationManager.location?.longitude)
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(WeatherViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
