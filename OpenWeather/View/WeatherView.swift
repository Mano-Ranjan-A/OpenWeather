//
//  WeatherView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if let todayWeather = viewModel.todaysWeather, let forcast = viewModel.forcastWeather {
                    List {
                        TodayWeatherView(todayWeather: todayWeather, showLocationIco: true)
                        ForcastView(forcastList: forcast.list)
                    }
                } else if viewModel.didErrorOccured {
                    ErrorView(errorType: viewModel.errotType)
                }
            }
            .refreshable {
                locationManager.requestLocation()
                Task {
                    await viewModel.fetchWeatherDataFor(lat: locationManager.location?.latitude,
                                                        lon: locationManager.location?.longitude)
                }
            }
            .onAppear {
                if viewModel.firstTimeLaunch {
                    viewModel.firstTimeLaunch = false
                    locationManager.requestLocation()
                    Task {
                        await viewModel.fetchWeatherDataFor(lat: locationManager.location?.latitude,
                                                            lon: locationManager.location?.longitude)
                    }
                }
            }
            if viewModel.isLoading {
                ActivityIndicatorView()
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
