//
//  WeatherDataView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TodayWeatherView: View {
    var todayWeather: TodayWeatherModel
    
    var showLocationIco = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // City name
                Text(todayWeather.city)
                    .font(.title)
                    .fontWeight(.semibold)
                if showLocationIco {
                    Image(systemName: "location.fill")
                }
            }
            
            Text("Today's weather")
            
            TemperatureView(style: TemperatureViewStyle(fontStyle: .system(size: 60),
                                                        weatherIcoScale: 2),
                            temperture: "\(todayWeather.temperature.temp.roundToInt)°C",
                            weatherId: todayWeather.weather.first?.id ?? 0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
            
            HStack {
                Text("Feels like \( todayWeather.temperature.temp.roundToInt )°C")
                Spacer()
                Text("\( todayWeather.temperature.tempMin.roundToInt )°C ~ \( todayWeather.temperature.tempMax.roundToInt )°C")
            }
            Text(todayWeather.weather.first?.description.capitalizeFirstLetter ?? "")
                .font(.callout)
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(todayWeather: previewData.todayWeatherPreviewData)
    }
}
