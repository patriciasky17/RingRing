//
//  AppDelegate.swift
//  RingRing
//
//  Created by Patricia Ho on 26/03/23.
//

import UIKit
import OneSignal

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("9268f760-aef5-4f7a-98b1-0cee933bd1d1")
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        
        setupExternalId()
        
        return true
      }
  
      private func setupExternalId() {
        let externalUserId = randomString(of: 10)
      
        OneSignal.setExternalUserId(externalUserId, withSuccess: { results in
          print("External user id update complete with results: ", results!.description)
          if let pushResults = results!["push"] {
            print("Set external user id push status: ", pushResults)
          }
          if let emailResults = results!["email"] {
            print("Set external user id email status: ", emailResults)
          }
          if let smsResults = results!["sms"] {
            print("Set external user id sms status: ", smsResults)
          }
        }, withFailure: {error in
          print("Set external user id done with error: " + error.debugDescription)
        })
      }
  
  
      private func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
          s.append(letters.randomElement()!)
        }
        return s
      }
}
