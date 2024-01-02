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
                        TodayWeatherView(todayWeather: todayWeather,
                                         showLocationIco: true)
                        ForcastView(forcastList: WeatherViewModel.forcastPreviewData)
                            
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
                await viewModel.fetchWeatherDataFor(lat: locationManager.location?.latitude,
                                                    lon: locationManager.location?.longitude)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchWeatherDataFor(lat: locationManager.location?.latitude,
                                                    lon: locationManager.location?.longitude)
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
