//
//  AppDelegate.swift
//  Bakgorund
//
//  Created by Zirbes, Richard on 8/29/19.
//  Copyright © 2019 Zirbes, Richard. All rights reserved.
//

import UIKit
import UserNotificationsUI
import UserNotifications

import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var notification: NSNotification?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        os_log("RICHIE - didFinishLaunchingWithOptions launchOptions: %{public}@", launchOptions ?? [:])
        os_log("RICHIE - didFinishLaunchingWithOptions COUNT: %ld", (launchOptions ?? [:]).count)
        
        if let options = launchOptions {
            os_log("RICHIE - got options: %ld ", options.count)
            for (key, value) in options {
                let lookup = key.rawValue
                if let obj = value as? NSObject {
                    let str = "obj: \(obj)"
                    os_log("RICHIE - %@ & %@", lookup, str)
                }
            }
            // DEPRECATED
            if let notification = options[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification {
                os_log("RICHIE - NOTE: %{public}@", notification)
                application.applicationIconBadgeNumber = 10
                if let action = notification.alertAction {
                    os_log("RICHIE - ACTION: %@", action)
                }
                if let info = notification.userInfo {
                    os_log("RICHIE - INFO: %@", info)
                }
            }
        }
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: options) {
            (granted, error) in
            print("registered")
            if !granted {
                print("Something went wrong")
            }
            self.postNotification()
        }
        center.delegate = self
        return true
    }
    
    func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!",
                                                                arguments: nil)
        content.badge = 42
        content.subtitle = "subtitle"
        content.userInfo = ["user": "info"]
        content.sound = UNNotificationSound.default
        
        let date = Date(timeIntervalSinceNow: 5.0)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(
            [.calendar, .timeZone,
             .era, .quarter,
             .year, .month, .day,
             .hour, .minute, .second, .nanosecond,
             .weekday, .weekdayOrdinal,
             .weekOfMonth, .weekOfYear, .yearForWeekOfYear],
            from: date)
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // why bad?
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            print("queued: \(error)")
            if let theError = error {
                print(theError.localizedDescription)
            }
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { (requests) in
                print("REQUESTS: \(requests.count)")
            })
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                print("SETTINGS: \(settings)")
            })
        }
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


}


extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive: \(response)")
        os_log("RICHIE - didReceive: %@", response)
        completionHandler()
        
//        AppDelegate.notification = ...
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("openSettingsFor: \(notification)")
        if let note = notification {
            os_log("RICHIE - openSettingsFor: %@", note)
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent: \(notification)")
        os_log("RICHIE - willPresent: %@", notification)
    }
    
    
    
    
}


