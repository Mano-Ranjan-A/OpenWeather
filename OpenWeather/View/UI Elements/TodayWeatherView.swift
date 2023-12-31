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
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(todayWeather.cityName)
                    .font(.title)
                    .fontWeight(.semibold)
                if showLocationIco {
                    Image(systemName: isLatestLocation ? "location.fill" : "location")
                }
            }
            
            Text("Todays weather")
            
            let ico = "cloud" //viewModel.getWeatherIcoName(for: todayWeather.weather.first?.id)
            TemperatureView(temperture: "\(todayWeather.temperature.avgTemp)",
                            style: TemperatureViewStyle(fontStyle: .system(size: 60),
                                                        weatherIcoScale: 2,
                                                        weatherIco: ico,
                                                        weatherColor: .blue))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            
            HStack {
                Text("Feels like \(todayWeather.temperature.feelLike)°C")
                Spacer()
                Text("\(todayWeather.temperature.minTemp)°C ~ \(todayWeather.temperature.maxTemp)°C")
            }
            Text(todayWeather.weather.first?.description ?? "")
                .font(.callout)
                .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(todayWeather: WeatherViewModel.todayWeatherPreviewData, isLatestLocation: true)
    }
}
