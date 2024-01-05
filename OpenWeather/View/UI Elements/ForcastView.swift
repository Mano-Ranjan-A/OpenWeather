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
            
            Text(OpenWeatherConstants.forcastMsg)
                .font(.title2)
                .fontWeight(.medium)
            
            ForEach(forcastList) { perDayForcast in
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(getDateFrom(time: perDayForcast.dt))
                            .font(.title3)
                        Text(perDayForcast.weather.first?.description.capitalizeFirstLetter ?? "")
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    let temp = "\(perDayForcast.temperature.temp.roundToInt)°C"
                    TemperatureView(style: TemperatureViewStyle(),
                                    temperture: temp,
                                    weatherId: perDayForcast.weather.first?.id ?? 0)
                    
                    .frame(maxWidth: 100)
                }
            }
        }
    }
    
    /// Method to return date in "Fri, Jan 5" formate or Today or Tomorrow depending on the date
    func getDateFrom(time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        
        guard !Calendar.current.isDateInToday(date) else {
            return "Today"
        }
        guard !Calendar.current.isDateInTomorrow(date) else {
            return "Tomorrow"
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EE MMM, d"
        let formatedDate = dateFormater.string(from: date)
        return formatedDate
    }
}


struct ForcastView_Previews: PreviewProvider {
    static var previews: some View {
        ForcastView(forcastList: previewData.forcastPreviewData)
    }
}
