//
//  PicALocView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct PicALocView: View {
    
    @StateObject var viewModel = PicALocViewModel()
    
    @State var showWeatherForcast = false
    @State var cityName: String = "" // setting city name as empty by default
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: Search field
                TextField("Enter city name", text: $cityName, onCommit: performWeatherSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .tint(.accentColor)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                Spacer()
                
                // MARK: Search message view
                if viewModel.showSearchMessage {
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
                
                // MARK: Weather view
                if let weather = viewModel.todaysWeather, let forcast = viewModel.forcastWeather {
                    List {
                        TodayWeatherView(todayWeather: weather)
                        ForcastView(forcastList: forcast.list)
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchWeatherDataFor(city: cityName)
                        }
                    }
                } else if viewModel.didErrorOccured && !viewModel.isLoading {
                    ErrorView(errorType: .apiError)
                }
            }
            if viewModel.isLoading {
                ActivityIndicatorView()
            }
        }
    }
    
    func performWeatherSearch() {
        Task {
            await viewModel.fetchWeatherDataFor(city: cityName)
        }
    }
}

struct PicALocView_Previews: PreviewProvider {
    static var previews: some View {
        PicALocView()
    }
}
