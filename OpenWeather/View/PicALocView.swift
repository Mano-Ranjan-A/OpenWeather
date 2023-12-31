//
//  PicALocView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct PicALocView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @EnvironmentObject var viewModel: WeatherViewModel
    
    @State var showWeatherForcast = false
    @State var cityName: String = "" // setting city name as empty by default
    
    var body: some View {
        VStack {
            // Search field
            TextField("Enter city name", text: $cityName, onCommit: performWeatherSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.webSearch)
                .onAppear() {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            
            if !showWeatherForcast {
                if networkManager.isNetworkAvailble {
                    // TODO: Doo API call
                    let apiSuccess = true
                    if apiSuccess {
                        List {
                            TodayWeatherView()
                            ForcastView()
                        }
                    } else {
                        ErrorView(errorType: .apiError)
                    }
                } else {
                    ErrorView(errorType: .networkError)
                }
            } else {
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
            
        }
    }
    
    func performWeatherSearch() {
        self.showWeatherForcast = true
    }
}

struct PicALocView_Previews: PreviewProvider {
    static var previews: some View {
        PicALocView()
            .environmentObject(NetworkManager())
            .environmentObject(WeatherViewModel())
    }
}
