//
//  LocationManager.swift
//  RingRing
//
//  Created by Patricia Ho on 25/03/23.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    @Published var locationStatus: String = ""
    
    let geofenceRegionRadius = 800.0 // in meters
    
    let geofenceRegionCenter = CLLocationCoordinate2D(latitude: -6.257757, longitude: 106.625395)
    
//    let geofenceRegionCenter = CLLocationCoordinate2D(latitude: -6.302160, longitude: 106.652535)
    
//    let geofenceRegionCenter = CLLocationCoordinate2D(latitude: -6.282978, longitude: 106.634021)
    
    // -6.282978, 106.634021 (Kos)

    
    //-6.302160, 106.652535 (Apple Developer Academy Location)
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // Create a circular region around the geofenceRegionCenter location
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: geofenceRegionRadius, identifier: "GeofenceRegion")
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = false
        
        // Start monitoring for the circular region
        locationManager.startMonitoring(for: geofenceRegion)
    }
    
    func requestLocationPermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func sendNotification() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        guard let userLocation = locationManager.location else {
            return
        }
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: geofenceRegionRadius, identifier: "GeofenceRegion")
        
        if geofenceRegion.contains(userLocation.coordinate){
            let content = UNMutableNotificationContent()
            content.title = "You're in the area!"
            content.body = "You've entered the Apple Developer Academy @BINUS Area and are receiving this notification."
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "geofenceNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
    }
    
    func sendPushNotification(message: [String: String], campaignName: String) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Basic ZDFkZmJlNDUtNzZiOS00NTZjLWEyMDktODFmYWExMTE3ZTVm",
            "content-type": "application/json"
        ]
        let parameters = [
            "app_id": "9268f760-aef5-4f7a-98b1-0cee933bd1d1",
            "included_segments": ["Active Users"],
            "headings": ["en": "BREAK'S OVER"],
            "ios_sound": "Breaks Over Tim 1.wav",
            "contents": message,
            "name": campaignName
        ] as [String : Any]
        let postData = try? JSONSerialization.data(withJSONObject: parameters)

        let request = NSMutableURLRequest(url: URL(string: "https://onesignal.com/api/v1/notifications")!,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 5.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error sending push notification: \(error.localizedDescription)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Push notification sent with status code \(httpResponse.statusCode)")
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response string: \(responseString)")
            }
        })

        dataTask.resume()
    }
    
    func send(completion: @escaping (Result<Data, Error>) -> Void) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        guard let userLocation = locationManager.location else {
            return
        }
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: geofenceRegionRadius, identifier: "GeofenceRegion")
        
        if geofenceRegion.contains(userLocation.coordinate){
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
                success, error in
                if success {
                    print("All Set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            let message = ["en": "Time to go back to the lab!!", "es": "¡Hola, Mundo!"]
            let campaignName = "Ring Ring!"
            sendPushNotification(message: message, campaignName: campaignName)
            
//            let content = UNMutableNotificationContent()
//            content.title = "BREAK'S OVER"
//            content.body = "Time to go back to the lab!"
//            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Breaks Over Tim 1.wav"))
//
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//            let req = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//            UNUserNotificationCenter.current().add(req) { error in
//                if error != nil {
//                    // Handle error
//                    print("Error")
//                    completion(.failure(error!))
//                } else {
//                    completion(.success(Data()))
//                }
//            }
        }
    }
}


