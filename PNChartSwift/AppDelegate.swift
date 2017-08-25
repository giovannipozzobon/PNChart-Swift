//
//  AppDelegate.swift
//  ManagementTool
//
//  Created by Giovanni Pozzobon on 07/04/17.
//  Copyright © 2017 Giovanni Pozzobon. All rights reserved.
//

import UIKit
import WatchConnectivity
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
 
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 e 8 support
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate =  self
            session.activate()
        }
        
        return true

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // =========================================================================
    // MARK: - WCSessionDelegate
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print(#function)
        print(session)
        print("reachable:\(session.isReachable)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print(#function)
        
        guard message["request"] as? String == "fireLocalNotification" else {return}
   
        // iOS 10 support
        if #available(iOS 10, *) { // Attenzione la versione iOS 10 non è mai stata utilizzata
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default()
            content.title = "Message Received!"
            
            _ = UNNotificationRequest(identifier: "id", content: content, trigger: nil)
        }
            // iOS 9 e 8 support
        else {
            let localNotification = UILocalNotification()
            localNotification.alertBody = "Message Received!"
            localNotification.fireDate = Date()
            localNotification.soundName = UILocalNotificationDefaultSoundName;
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    
    // Queste funzioni per eliminare l'errore "AppDelegate Does not Conform to WCSessionDelegate"
    // https://forums.developer.apple.com/thread/49198
    // https://stackoverflow.com/questions/38574384/watch-networking-broken-in-xcode-8-beta-3
    // https://stackoverflow.com/questions/39513461/wcsessiondelegate-sessiondidbecomeinactive-and-sessiondiddeactivate-have-been-m
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == WCSessionActivationState.activated {
            NSLog("Activated")
        }
        
        if activationState == WCSessionActivationState.inactive {
            NSLog("Inactive")
        }
        
        if activationState == WCSessionActivationState.notActivated {
            NSLog("NotActivated")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        NSLog("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        NSLog("sessionDidDeactivate")
        
        // Begin the activation process for the new Apple Watch.
        WCSession.default().activate()
    }

}

