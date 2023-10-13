//
// UserPreferencesManager.swift
//

import Foundation
import UIKit
import AdSupport

class UserPreferencesManager: PreferencesManager {
    private static let INDEX_PREFER_ORDER_TYPE = "UserPreferencesManager.INDEX_PREFER_ORDER_TYPE"
    private static let INDEX_PREFER_NUMBER_REPEAT = "UserPreferencesManager.INDEX_PREFER_NUMBER_REPEAT"
    private static let INDEX_PREFER_NUMBER_MIN = "UserPreferencesManager.INDEX_PREFER_NUMBER_MIN"
    private static let INDEX_PREFER_NUMBER_MAX = "UserPreferencesManager.INDEX_PREFER_NUMBER_MAX"
    
    static func getUserPrefersOrderType() -> Int {
        return getUserSettingInt(INDEX_PREFER_ORDER_TYPE, 0)
    }
    static func setUserPrefersOrderType(_ value: Int) {
        return setUserSettingInt(INDEX_PREFER_ORDER_TYPE, value)
    }
    
    static func getUserPrefersNumberRepeat() -> Bool {
        return getUserSettingBool(INDEX_PREFER_NUMBER_REPEAT, true)
    }
    static func setUserPrefersNumberRepeat(_ value: Bool) {
        return setUserSettingBool(INDEX_PREFER_NUMBER_REPEAT, value)
    }
    static func toggleUserPrefersNumberRepeat() {
        let value = getUserPrefersNumberRepeat()
        return setUserSettingBool(INDEX_PREFER_NUMBER_REPEAT, !value)
    }
    
    static func getUserPrefersNumberMin() -> Int {
        return getUserSettingInt(INDEX_PREFER_NUMBER_MIN, 0)
    }
    static func setUserPrefersNumberMin(_ value: Int) {
        return setUserSettingInt(INDEX_PREFER_NUMBER_MIN, value)
    }
    
    static func getUserPrefersNumberMax() -> Int {
        return getUserSettingInt(INDEX_PREFER_NUMBER_MAX, 100)
    }
    static func setUserPrefersNumberMax(_ value: Int) {
        return setUserSettingInt(INDEX_PREFER_NUMBER_MAX, value)
    }
    
}


