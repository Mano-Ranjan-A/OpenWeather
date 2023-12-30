//
//  ForcastView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct ForcastView: View {
    
    var todaysDesc: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Weather forecast for next 5 days")
                .font(.title2)
                .fontWeight(.medium)
            ForEach(0..<5) { _ in
                HStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Tomorrow")
                            .font(.title3)
                        Text(todaysDesc)
                    }
                    TemperatureView(temperture: 28, style: TemperatureViewStyle(weatherIco: "cloud.fill", weatherColor: .blue))
                }
            }
        }
        .padding()
    }
}


struct ForcastView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastView(todaysDesc: "Mostly Coludy")
    }
}
