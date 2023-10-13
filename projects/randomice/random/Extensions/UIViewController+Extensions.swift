//
//  UIViewController+Extensions.swift
//  

import UIKit
import Foundation
import SnapKit

extension UIViewController {
    func removeAllFromParent() {
        willMove(toParent: nil)
        view.snp.removeConstraints()
        view.removeFromSuperview()
        didMove(toParent: nil)
        removeFromParent()
    }
}

