//
//  TemperatureView.swift
//  OpenWeather
//
//  Created by Mano on 29/12/23.
//

import SwiftUI

struct TemperatureViewStyle {
    var fontStyle: Font = .body
    var weatherIcoScale: CGFloat = 1
    
    /// method to get weather icon system name and color based on the weather id
    func getWeatherIcoAndColorName(for weatherId: Int) -> (String, Color) {
        switch weatherId {
        case 200..<235:
            return ("cloud.bolt.rain.fill", .yellow)
        case 300..<325:
            return ("cloud.sun.rain.fill", .blue)
        case 500..<535:
            return ("cloud.heavyrainfall.fill", .gray)
        case 600..<625:
            return ("snow", .accentColor)
        case 700..<800:
            return ("cloud.fog.fill", .blue)
        case 801, 802:
            return ("cloud.sun.fill", .orange)
        case 803, 804:
            return ("smoke.fill", .gray)
        case 800:
            return ("sun.max.fill", .red)
        default:
            return ("xmark.iclouf.fill", .red)
        }
    }
}

struct TemperatureView: View {
    
    var icoSize: CGFloat {
        return style.weatherIcoScale * 40
    }
    
    var style: TemperatureViewStyle
    var temperture: String
    var weatherId: Int
    
    var body: some View {
        HStack {
            Text(temperture)
                .font(style.fontStyle)
                .fontWeight(.bold)
            Spacer()
            let (ico, color) = style.getWeatherIcoAndColorName(for: weatherId)
            Image(systemName: ico)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: icoSize ,
                       height: icoSize,
                       alignment: .center)
                .foregroundColor(color)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(style: TemperatureViewStyle(), temperture: "28°C", weatherId: 204)
    }
}
