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
            if networkManager.isNetworkAvailble && locationManager.isLocationAuthorised {
                // TODO: Call weather API
                let apiSuccess = true
                if apiSuccess {
                    List {
                        guard let todayWeather = viewModel.todayWeather, let forcast = viewModel.forcastWeather else {
                                ErrorView(errorType: .apiError)
                        }
                        TodayWeatherView()
                        ForcastView()
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
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(NetworkManager())
            .environmentObject(WeatherViewModel())
    }
}
