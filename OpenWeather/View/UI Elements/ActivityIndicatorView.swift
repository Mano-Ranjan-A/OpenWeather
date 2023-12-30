//
//  ActivityIndicatorView.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(CGSize(width: 2.0, height: 2.0))
                .foregroundColor(.accentColor)
            Text("Featching your weather data")
                .font(.title3)
                .fontWeight(.semibold)
                .offset(x: 0, y: 25.0)
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
