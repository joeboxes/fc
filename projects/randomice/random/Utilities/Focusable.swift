//
//  Focusable.swift
//  

import Foundation
import UIKit


protocol Focusable {
    func didGetFocus(_ context: Any?)
    func didLoseFocus(_ context: Any?)
}

class FocusableController: UIViewController, Focusable {
    var hasFocus = false
    func didGetFocus(_ context: Any?) {
        if hasFocus {
            return
        }
        hasFocus = true
    }
    func didLoseFocus(_ context: Any?) {
        if !hasFocus {
            return
        }
        hasFocus = false
    }
    
    var supportedOrientationsVisual: UIInterfaceOrientationMask {
        get {
            return [UIInterfaceOrientationMask.portrait, UIInterfaceOrientationMask.portraitUpsideDown]
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return supportedOrientationsVisual
    }
    
    func supportedOrientationVisualPortrait() -> Bool {
        let orientationMask = self.supportedOrientationsVisual
        return orientationMask.contains(.portrait) || orientationMask.contains(.portraitUpsideDown)
    }
    func supportedOrientationVisualLandscape() -> Bool {
        let orientationMask = self.supportedOrientationsVisual
        return orientationMask.contains(.landscapeLeft) || orientationMask.contains(.landscapeRight)
    }
    func supportedOrientationVisualLandscapeOnly() -> Bool {
        return !supportedOrientationVisualPortrait()
    }
    func supportedOrientationVisualPortraitOnly() -> Bool {
        return !supportedOrientationVisualLandscape()
    }
}






