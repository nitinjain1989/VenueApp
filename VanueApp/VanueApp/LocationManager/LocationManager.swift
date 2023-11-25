//
//  LocationManager.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    static let shared: LocationManager = LocationManager()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied: // Setting option: Never
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined: // Setting option: Ask Next Time
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse: // Setting option: While Using the App
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
        case .authorizedAlways: // Setting option: Always
            print("LocationManager didChangeAuthorization authorizedAlways")
            print(manager.location?.coordinate.latitude)
        case .restricted: // Restricted by parental control
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
    //Handle the location information
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations:\(locations)")
    }
    //Invoked when an error has occurred
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error)")
    }
}
