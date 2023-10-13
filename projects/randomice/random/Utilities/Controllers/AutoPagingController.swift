//
//  AutoPagingController.swift
//

import Foundation
import UIKit
import SnapKit

class AutoPagingController: FocusableController {
    
    static var instance: AutoPagingController?
    
    static func gotoController(_ controller: FocusableController, _ title: String = "", _ nextIndex: Int = 0) {
        if let nav = instance {
            nav.gotoController(controller, title, nextIndex)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var currentTabIndex: Int = 0
    private var navigation: AutoNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = AutoNavigationController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: .horizontal)
        nav.willMove(toParent: self)
        addChild(nav)
        view.addSubview(nav.view)
        nav.view.snp.makeConstraints(){ make in
            make.edges.equalToSuperview()
        }
        
        nav.didMove(toParent: self)
        navigation = nav
    }
    
//    var pageStyle: UIPageViewController.TransitionStyle { // .scroll  .pageCurl
//        set {
//            navigation?.transitionStyle = newValue
//        }
//        get {
//            return navigation?.transitionStyle ?? UIPageViewController.TransitionStyle.scroll
//        }
//    }
    
    func gotoController(_ controller: UIViewController, _ title: String = "", _ nextIndex: Int = 0) {
        let feedback = UISelectionFeedbackGenerator()
        feedback.prepare()
        feedback.selectionChanged()
        
        guard let nav = navigation else { return }
        
        let _ = controller.view // ensure viewDidLoad called ?
        
        if hasFocus {
            for controllers in nav.viewControllers! {
                if let focus = controllers as? Focusable {
                    focus.didLoseFocus(self)
                }
            }
            if let focus = controller as? Focusable {
                focus.didGetFocus(self)
            }
        }
        
        let navControllers = [controller]
        
        if nextIndex < currentTabIndex {
            nav.setControllers(navControllers, .right) {
                self.competedAnimationController(controller)
            }
        } else {
            nav.setControllers(navControllers, .left) {
                self.competedAnimationController(controller)
            }
        }
        currentTabIndex = nextIndex
    }
    
    private func competedAnimationController(_ controller: UIViewController) {
        DispatchQueue.main.async {
            // can now do something
        }
    }
    
}
