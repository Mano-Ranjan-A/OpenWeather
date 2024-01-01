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
    
    func getWeatherData(from url: URL) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            return nil // As we are not going to show generic error we don't care what error occured
        }
    }
    
}
