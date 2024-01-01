//
//  WeatherDataView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TodayWeatherView: View {
    @State var todayWeather: TodayWeatherModel
    @State var isLatestLocation: Bool = false
    
    var showLocationIco = false
    var weatherIco: String
    var weatherColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // City name
                Text(todayWeather.city)
                    .font(.title)
                    .fontWeight(.semibold)
                if showLocationIco {
                    Image(systemName: isLatestLocation ? "location.fill" : "location")
                }
            }
            
            Text("Todays weather")
            
            TemperatureView(temperture: "\(todayWeather.temperature.temp.limitToSingleDigitPrecision())",
                            style: TemperatureViewStyle(fontStyle: .system(size: 60),
                                                        weatherIcoScale: 2,
                                                        weatherIco: weatherIco,
                                                        weatherColor: weatherColor))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            
            HStack {
                Text("Feels like \(todayWeather.temperature.temp.limitToSingleDigitPrecision())°C")
                Spacer()
                Text("\(todayWeather.temperature.tempMin.limitToSingleDigitPrecision())°C ~ \(todayWeather.temperature.tempMax.limitToSingleDigitPrecision())°C")
            }
            Text(todayWeather.weather.first?.description ?? "")
                .font(.callout)
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(todayWeather: WeatherViewModel.todayWeatherPreviewData, isLatestLocation: true, weatherIco: "cloud.fill", weatherColor: .blue)
    }
}
