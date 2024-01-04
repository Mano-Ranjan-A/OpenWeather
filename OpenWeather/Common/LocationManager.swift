//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Mano on 30/12/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    
    var isLocationAuthorised: Bool = false
    
    var delegate: LocationManagerProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            self.isLocationAuthorised = false
            self.delegate?.didUpdateLocation(location: nil)
        case .authorizedWhenInUse, .authorizedAlways:
            self.isLocationAuthorised = true
            requestLocation()
        @unknown default:
            self.isLocationAuthorised = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.didUpdateLocation(location: locations.first?.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
