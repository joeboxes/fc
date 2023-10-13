//
//  NavigationController.swift
//

import Foundation
import UIKit

class NavigationController: AutoPagingController {
    
    static func requestShowAboutView() {
        let about = AboutViewController()
        gotoController(about, "about", 1)
    }
    
    static func requestShowHistoryView() {
        let history = HistoryViewController()
        gotoController(history, "history", 2)
    }
    
    static func requestShowRandomView() {
        let random = RandomViewController()
        gotoController(random, "random", 0)
    }
    
}
