//
//  PicALocView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct PicALocView: View {
    
    @EnvironmentObject var viewModel: WeatherViewModel
    
    @State var showWeatherForcast = false
    @State var cityName: String = "" // setting city name as empty by default
    @State var showSearchMessage = true
    
    var body: some View {
        ZStack {
            VStack {
                // Search field
                TextField("Enter city name", text: $cityName, onCommit: performWeatherSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .tint(.accentColor)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                Spacer()
                
                if showSearchMessage {
                    VStack {
                        Text("⛅️")
                            .font(.system(size: 60))
                        Text("Want to feel how weather is like in other parts of the world. Search the city to see whats it like there.")
                            .fontWeight(.medium)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    Spacer()
                }
                
                if let weather = viewModel.todaysWeather, let forcast = viewModel.forcastWeather {
                    List {
                        let (ico, color) = viewModel.getWeatherIcoAndColorName(for: weather.weather.first?.id)
                        TodayWeatherView(todayWeather: weather, weatherIco: ico, weatherColor: color)
                        ForcastView(forcastList: forcast.list, weatherIco: "cloud.fill", weatherColor: .blue)
                    }
                    .refreshable {
                        print("refresh")
                    }
                } else if !showSearchMessage && !viewModel.isLoading {
                    ErrorView(errorType: .apiError)
                }
            }
        }
            if viewModel.isLoading {
                ActivityIndicatorView()
            }
            
    }
    
    func performWeatherSearch() {
        self.showSearchMessage = false
        self.showWeatherForcast = true
        Task {
            await viewModel.fetchWeatherDataFor(city: cityName)
        }
    }
}

struct PicALocView_Previews: PreviewProvider {
    static var previews: some View {
        PicALocView()
            .environmentObject(WeatherViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
