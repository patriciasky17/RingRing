//
//  NotificationManager.swift
//  RingRing
//
//  Created by Patricia Ho on 25/03/23.
//

import SwiftUI
import CoreLocation


class NotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate  {
    
    @Published var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        self.authorizationStatus = settings.authorizationStatus
                    }
                }
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func registerDeviceToken(withToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("Device Token: \(tokenString)")
        // Send the device token to your server to enable remote notifications
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification received")
        completionHandler()
    }
}
