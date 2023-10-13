//
//  CGPoint+Extensions.swift
//  

import UIKit
import Foundation


extension CGPoint {
    
    static func length(_ point: CGPoint) -> CGFloat {
        return CGFloat( sqrt(point.x*point.x + point.y*point.y) )
    }
    
    static func unit(_ point: CGPoint) -> CGPoint {
        let length = CGPoint.length(point)
        if length > 0 {
            return CGPoint(x: point.x/length, y: point.y/length)
        }
        return CGPoint(x: 0, y: 0)
    }
    
    static func scale(_ point: CGPoint, _ scale: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scale, y: point.y * scale)
    }
    
    static func add(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return CGPoint(x: a.x + b.x, y: a.y + b.y)
    }
    
    static func sub(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return CGPoint(x: a.x - b.x, y: a.y - b.y)
    }
    
    static func dot(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        return (a.x * b.x) + (a.y * b.y)
    }
    
    func scale(_ scale: CGFloat) -> CGPoint {
        return CGPoint.scale(self, scale)
    }
    
    func length() -> CGFloat {
        return CGPoint.length(self)
    }
}

