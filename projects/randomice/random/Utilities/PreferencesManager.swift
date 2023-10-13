//
// PreferencesManager.swift
//

import Foundation
import UIKit

class PreferencesManager {
    static let NotificationPreferencesManagerUpdated = Notification.Name("PreferencesManager.NotificationPreferencesManagerUpdated")
    
    private static let INDEX_USER_PREFERENCE_RANDOM_DOUBLE = "PreferencesManager.INDEX_USER_PREFERENCE_RANDOM_DOUBLE"
    private static let INDEX_USER_UUID = "PreferencesManager.INDEX_USER_UUID"
    private static let INDEX_USER_APP_OPENS = "PreferencesManager.INDEX_USER_OPENED_APP"
    
    static func alertChanged() {
        NotificationCenter.default.post(Notification(name: PreferencesManager.NotificationPreferencesManagerUpdated, object: self, userInfo: nil))
    }
    
    // APP OPENS
    static func getUserAppOpens() -> Double {
        return getUserSettingDouble(INDEX_USER_APP_OPENS, 0)
    }
    static func incrementUserAppOpens() {
        let opens = getUserAppOpens() + 1
        setUserSettingDouble(INDEX_USER_APP_OPENS, opens)
    }
    
    // A/B TESTING
    static func getUserRandomNumber() -> Double {
        let d = drand48()
        return getUserSettingDouble(INDEX_USER_PREFERENCE_RANDOM_DOUBLE, d)
    }
    static func setUserRandomNumber(_ value: Double) {
        let previous = getUserRandomNumber()
        setUserSettingDouble(INDEX_USER_PREFERENCE_RANDOM_DOUBLE, value)
        if previous != value {
            alertChanged()
        }
    }
    
    // USER ID
    static func userUUID() -> String {
        let UUID = NSUUID().uuidString
        return getUserSettingString(INDEX_USER_UUID, UUID)
    }
    
    // DEVICE / VENDOR ID
    static func vendorUUID() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
    }
    
    // GET / SET
    
    static func getUserSettingBool(_ name: String, _ defaultValue: Bool) -> Bool {
        if UserDefaults.standard.object(forKey: name) == nil {
            UserDefaults.standard.set(defaultValue, forKey: name)
        }
        return UserDefaults.standard.bool(forKey: name)
    }
    static func setUserSettingBool(_ name: String, _ value: Bool) {
        return UserDefaults.standard.set(value, forKey: name)
    }
    
    static func getUserSettingDouble(_ name: String, _ defaultValue: Double) -> Double {
        if UserDefaults.standard.object(forKey: name) == nil {
            UserDefaults.standard.set(defaultValue, forKey: name)
        }
        return UserDefaults.standard.double(forKey: name)
    }
    static func setUserSettingDouble(_ name: String, _ value: Double) {
        return UserDefaults.standard.set(value, forKey: name)
    }
    
    static func getUserSettingInt(_ name: String, _ defaultValue: Int) -> Int {
        if UserDefaults.standard.object(forKey: name) == nil {
            UserDefaults.standard.set(defaultValue, forKey: name)
        }
        return UserDefaults.standard.integer(forKey: name)
    }
    static func setUserSettingInt(_ name: String, _ value: Int) {
        return UserDefaults.standard.set(value, forKey: name)
    }
    
    static func getUserSettingString(_ name: String, _ defaultValue: String) -> String {
        if UserDefaults.standard.object(forKey: name) == nil {
            UserDefaults.standard.set(defaultValue, forKey: name)
        }
        return UserDefaults.standard.string(forKey: name) ?? defaultValue
    }
     static func setUserSettingString(_ name: String, _ value: String) {
        return UserDefaults.standard.set(value, forKey: name)
    }
}


