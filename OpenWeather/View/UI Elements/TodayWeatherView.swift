//
//  WeatherDataView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TodayWeatherView: View {
    var cityName: String
    var todaysDesc: String
    var showLocationIco: Bool = true
    @State var isLatestLocation: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cityName)
                    .font(.title)
                    .fontWeight(.semibold)
                if showLocationIco {
                    Image(systemName: isLatestLocation ? "location.fill" : "location.slash.fill")
                }
            }
            
            Text("Todays weather")
            
            TemperatureView(temperture: "28°C", style: TemperatureViewStyle(fontStyle: .system(size: 60), weatherImgWidth: 80, weatherImgHeight: 80, weatherIco: "sun.max.fill", weatherColor: .blue))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            HStack {
                Text("Feels like 32°C")
                Spacer()
                Text("28°C ~ 34°C")
            }
            Text(todaysDesc)
                .font(.callout)
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(cityName: "Chennai", todaysDesc: "Mostly Cloudy today")
    }
}
