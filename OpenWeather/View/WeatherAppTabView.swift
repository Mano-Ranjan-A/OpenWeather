//
//  ContentView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct WeatherAppTabView: View {
    @State var reload = false
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    WeatherView()
                        .tabItem {
                            Label("Weather", systemImage: "cloud.sun.fill")
                        }
                    
                    PicALocView()
                        .tabItem {
                            Label("Search", systemImage: "location.fill")
                    }
                }
                .navigationTitle("Open Weather")
                .navigationBarTitleDisplayMode(.inline)
//                .toolbar(content: {
//                    Image(systemName: "arrow.clockwise.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 25, height: 25, alignment: .center)
//                        .foregroundColor(.accentColor)
////                        .rotationEffect(.degrees(180), anchor: .center)
//                        .onTapGesture {
//                            self.reload.toggle()
//                        }
//                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAppTabView()
            .environmentObject(NetworkManager())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
