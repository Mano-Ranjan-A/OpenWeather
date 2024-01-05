//
//  PicALocView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct PicALocView: View {
    @StateObject var viewModel = PicALocViewModel()
    
    @State var cityName: String = "" // setting city name as empty by default
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: Search field
                TextField(OpenWeatherConstants.enterCity, text: $cityName, onCommit: performWeatherSearch)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .tint(.accentColor)
                    .autocorrectionDisabled()
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                Spacer()
                
                // MARK: Search message view
                if viewModel.showSearchMessage {
                    VStack {
                        Text("⛅️")
                            .font(.system(size: 60))
                        Text(OpenWeatherConstants.searchMsg)
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
                        ForcastView(forcastList: forcast.list ?? [])
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchWeatherDataFor(city: cityName)
                        }
                    }
                } else if viewModel.didErrorOccured {
                    ErrorView(errorType: viewModel.errotType)
                    Spacer()
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
