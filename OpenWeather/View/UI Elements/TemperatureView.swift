//
//  TemperatureView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TemperatureViewStyle {
    var fontStyle: Font = .title3
    var weatherImgWidth: CGFloat = 40
    var weatherImgHeight: CGFloat = 40
    var weatherIco: String
    var weatherColor: Color
}

struct TemperatureView: View {
    var temperture: Int
    var style: TemperatureViewStyle
    var body: some View {
        HStack {
            Text("\(temperture)°C")
                .font(style.fontStyle)
            Spacer()
            Image(systemName: style.weatherIco)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: style.weatherImgWidth, height: style.weatherImgHeight, alignment: .center)
                .foregroundColor(style.weatherColor)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temperture: 28,  style: TemperatureViewStyle(weatherIco: "cloud.fill", weatherColor: .blue))
    }
}
