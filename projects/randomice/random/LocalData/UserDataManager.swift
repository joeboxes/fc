//
// UserDataManager.swift
//

import Foundation

class UserDataManager: StorageManager {
    
    private static let KEY_DATA_NUMBERS = "UserDataManager.KEY_DATA_NUMBERS"
    private static var dataNumbers: NSMutableArray!
    
    static func loadData() {
        let _ = numbers()
    }
    
    static func numbers() -> NSMutableArray {
        dataNumbers = getArray(KEY_DATA_NUMBERS, dataNumbers)
        return dataNumbers
    }
    
    static func saveAll() {
        let items = numbers()
        saveObject(KEY_DATA_NUMBERS, items)
    }
    
    static func addNumber(_ number: Int) -> Bool {
        let items = numbers()
        items.insert( NSNumber(integerLiteral: number), at: 0)
        return true
    }
    
    static func popNumber() -> Bool {
        let items = numbers()
        if items.count > 0 {
            items.removeObject(at: 0)
            return true
        }
        return false
    }
    
    static func clearNumbers() -> Bool {
        let items = numbers()
        items.removeAllObjects()
        return true
    }
}

