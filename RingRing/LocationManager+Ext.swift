//
//  LocationManager+Ext.swift
//  RingRing
//
//  Created by Patricia Ho on 25/03/23.
//

import CoreLocation

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            self.locationStatus = "Restricted Access to Location"
        case .denied:
            self.locationStatus = "Please grant permission for location access in Settings"
        case .notDetermined:
            self.locationStatus = "Location permission not granted"
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationStatus = "Location access granted"
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationStatus = "Error"
        print(error.localizedDescription)
    }
}
