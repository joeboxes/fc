//
//  AutoNavigationController.swift
//

import Foundation
import UIKit

class AutoNavigationController: UIPageViewController {
    
    enum AnimationDirection {
        case left
        case right
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setControllers(_ controllers: [UIViewController], _ direction: AnimationDirection = .left, _ complete: (()->Void)? ) {
        setViewControllers(controllers, direction: direction == .left ? .forward : .reverse, animated: true) { done in
            if let _complete = complete {
                _complete()
            }
        }
    }
    
    var hasFocus = false
    func didGetFocus(_ context: Any?) {
        if hasFocus {
            return
        }
        hasFocus = true
        for controller in children {
            if let focusable = controller as? Focusable {
                focusable.didGetFocus(self)
            }
        }
    }
    func didLoseFocus(_ context: Any?) {
        if !hasFocus {
            return
        }
        hasFocus = false
        for controller in children {
            if let focusable = controller as? Focusable {
                focusable.didLoseFocus(self)
            }
        }
    }
    
}
