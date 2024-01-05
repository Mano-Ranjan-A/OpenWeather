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
                Text(todayWeather.city ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                if showLocationIco {
                    Image(systemName: "location.fill")
                }
            }
            
            Text(OpenWeatherConstants.todaysWeather)
            if let temperature = todayWeather.temperature, let weather = todayWeather.weather {
                TemperatureView(style: TemperatureViewStyle(fontStyle: .system(size: 60), weatherIcoScale: 2),
                                temperture: "\(temperature.temp.roundToInt)°C",
                                weatherId: weather.first?.id ?? 0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
                
                HStack {
                    Text("Feels like \( temperature.temp.roundToInt )°C")
                    Spacer()
                    let minTemp = temperature.tempMin.roundToInt
                    let maxTemp = temperature.tempMax.roundToInt
                    let tempRange = "\(minTemp)°C ~ \(maxTemp)°C"
                    Text( tempRange )
                }
                Text(todayWeather.weather?.first?.description.capitalizeFirstLetter ?? "")
                    .font(.callout)
                    .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(todayWeather: previewData.todayWeatherPreviewData)
    }
}
