//
// StorageManager.swift
//

import Foundation

class StorageManager {
    
    static func saveObject(_ key: String, _ object: Any) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(data, forKey: key) // NOT NECESSARY: UserDefaults.standard.synchronize()
    }
    
    static func loadObject(_ key: String) -> Any? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        guard let object = NSKeyedUnarchiver.unarchiveObject(with: data) else {
            return nil
        }
        return object
    }
    
    static func getArray(_ key: String, _ items: NSMutableArray?) -> NSMutableArray { // default to empty
        if let _items = items{
            return _items
        } else {
            print("REQUIRE LOADING")
            if let all = StorageManager.loadObject(key) as? NSMutableArray {
                print("all: \(all)")
                return all
            } else {
                let newItems = NSMutableArray()
                saveObject(key, newItems)
                return newItems
            }
        }
    }
}


