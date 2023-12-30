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
            
            TemperatureView(temperture: 28, style: TemperatureViewStyle(fontStyle: .system(size: 60), weatherImgWidth: 80, weatherImgHeight: 80, weatherIco: "cloud.fill", weatherColor: .blue))
                
            Text(todaysDesc)
        }
        .padding()
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(cityName: "Chennai", todaysDesc: "Mostly Cloudy today")
    }
}
