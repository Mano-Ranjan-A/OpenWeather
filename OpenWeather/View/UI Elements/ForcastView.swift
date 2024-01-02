//
//  ForcastView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct ForcastView: View {
    var forcastList: [ForcastList]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Weather forecast for next 5 days")
                .font(.title2)
                .fontWeight(.medium)
            ForEach(forcastList) { perDayForcast in
                HStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(getDayFrom(time: perDayForcast.dt))
                            .font(.title3)
                        Text(perDayForcast.weather.first?.description.capitalizeFirstLetter ?? "")
                            .font(.subheadline)
                    }
                    
                    let tempRange = "\( Int(perDayForcast.temperature.tempMin) )°C ~ \( Int(perDayForcast.temperature.tempMax) )°C"
                    
                    TemperatureView(style: TemperatureViewStyle(),
                                    temperture: tempRange,
                                    weatherId: perDayForcast.weather.first?.id ?? 0)
                }
            }
        }
    }
    
    func getDayFrom(time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        return "Tomorrow"
    }
}


struct ForcastView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastView(forcastList: previewData.forcastPreviewData)
    }
}
