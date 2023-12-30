//
//  ErrorView.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import SwiftUI

enum ErrorType {
    case noLocationAccess
    case networkError
    case apiError
    
    var errIco: String {
        switch self {
        case .networkError:
            return "wifi.slash"
        case .apiError:
            return "exclamationmark.icloud.fill"
        case .noLocationAccess:
            return "location.slash.fill"
        }
    }
    
    var errDesc: String {
        switch self {
        case .networkError:
            return "Oops seems like you are not connected to network"
        case .apiError:
            return "Oops sorry for that, its not you its us. Bad weather at our end 😅."
        case .noLocationAccess:
            return "Allow location access to display weather data of your current location."
        }
    }
}

struct ErrorView: View {
    var errorType: ErrorType
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: errorType.errIco)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                .frame(width: 50, height: 50, alignment: .center)
            Text(errorType.errDesc)
                .fontWeight(.medium)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorType: .noLocationAccess)
    }
}
