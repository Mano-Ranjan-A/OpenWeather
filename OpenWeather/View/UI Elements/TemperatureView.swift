//
//  TemperatureView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TemperatureViewStyle {
    
    var fontStyle: Font = .title3
    var weatherIcoScale: CGFloat = 1
    var weatherIco: String
    var weatherColor: Color
}

struct TemperatureView: View {
    
    var icoSize: CGFloat {
        return style.weatherIcoScale * 40
    }
    
    var temperture: String
    var style: TemperatureViewStyle
    var body: some View {
        HStack {
            Text(temperture)
                .font(style.fontStyle)
            Spacer()
            Image(systemName: style.weatherIco)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: icoSize ,
                       height: icoSize,
                       alignment: .center)
                .foregroundColor(style.weatherColor)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temperture: "28°C",  style: TemperatureViewStyle(weatherIco: "cloud.fill", weatherColor: .blue))
    }
}
