//
//  NSObject+Extensions.swift
//  

import UIKit
import Foundation

extension NSObject {
    
    func callSelectorAsync(selector: Selector, object: AnyObject?, delay: TimeInterval) -> Timer {
        let timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: selector, userInfo: object, repeats: false)
        return timer
    }
    
}

