//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation
import Network

class NetworkManager {
    private let networkMonitor = NWPathMonitor()
    private let networkMonitorQueue = DispatchQueue(label: "monitorQueue")
    
    var isNetworkAvailble = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isNetworkAvailble = path.status == .satisfied
        }
        networkMonitor.start(queue: networkMonitorQueue)
    }
    
    static func getWeatherData(from: URL) {
        
    }
    
}
