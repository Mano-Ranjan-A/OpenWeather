//
//  WeatherView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherView: View {
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
                viewModel.fetchWeather()
            }
            .onAppear {
                if viewModel.firstTimeLaunch || viewModel.todaysWeather == nil {
                    viewModel.firstTimeLaunch = false
                    viewModel.fetchWeather()
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
