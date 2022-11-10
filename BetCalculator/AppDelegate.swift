//
//  AppDelegate.swift
//  BetCalculator
//
//  Created by Игорь Майсюк on 10.11.22.
//

import AppsFlyerLib
import AdSupport
import AppTrackingTransparency

import FBSDKCoreKit
import FirebaseCore

import OneSignal

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        FirebaseApp.configure()
        
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.onesignalKey)

        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        
        application.registerForRemoteNotifications()
        
        AppsFlyerLib.shared().isDebug = false
        
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsflyerKey
        AppsFlyerLib.shared().appleAppID = Constants.appleID
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    @objc func didBecomeActiveNotification() {
        AppsFlyerLib.shared().start()
        requestIDFA()
    }
    
    func requestIDFA() {
        ATTrackingManager.requestTrackingAuthorization { _ in }
    }
}

extension Constants {
    static func getMainURL(includeParams: Bool) -> URL {
        guard includeParams else { return baseUrl }
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        var items: [URLQueryItem] = [.init(name: "afid", value: AppsFlyerLib.shared().getAppsFlyerUID()),
                                     .init(name: "os", value: UIDevice.current.systemVersion)]
        let status = ATTrackingManager.trackingAuthorizationStatus
        if status == .authorized {
            let idfa = ASIdentifierManager.shared().advertisingIdentifier
            items.append(.init(name: "idfa", value: idfa.uuidString))
        }
        urlComponents?.queryItems = items
        return urlComponents?.url ?? baseUrl
    }
}
