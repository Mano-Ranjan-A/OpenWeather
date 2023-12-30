//
//  PicALocView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct PicALocView: View {
    
    @EnvironmentObject var networkManager: NetworkManager
    @Binding var reload: Bool
    
    @State var showWeatherView = false
    @State var showWeatherForcast = false
    @State var city: String = ""
    @State var isPresented = false
    
    var body: some View {
        VStack {
            // Search field
            TextField("Enter city name or zip code", text: $city, onCommit: performWeatherSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.webSearch)
                .onAppear() {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            
            Spacer()
            
            if showWeatherForcast {
                if networkManager.isNetworkAvailble {
                    // TODO: Doo API call
                    let apiSuccess = true
                    if apiSuccess {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                TodayWeatherView(cityName: "Chennai", todaysDesc: "Mostly Cloudy today",showLocationIco: false)
                                ForcastView(todaysDesc: "Mostly Cloudy")
                            }
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
        .onChange(of: reload, perform: { _ in
            if isPresented {
                showWeatherView.toggle()
            }
        })
        .onAppear() {
            if !networkManager.isNetworkAvailble {
            showWeatherView = false
        }
            self.isPresented = true
        }
        .onDisappear() {
            self.isPresented = false
        }
    }
    
    func performWeatherSearch() {
        self.showWeatherForcast = true
    }
}

struct PicALocView_Previews: PreviewProvider {
    static var previews: some View {
        PicALocView(reload: .constant(false))
            .environmentObject(NetworkManager())
    }
}
