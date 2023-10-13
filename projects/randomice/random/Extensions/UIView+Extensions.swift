//
//  UIView+Extensions.swift
//  

import UIKit
import Foundation

extension UIView {
    
    func removeAllSubviews(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setShadowing(_ distance: CGFloat = 5, _ fade: CGFloat = 0.5, _ offX: CGFloat = 0.0,  _ offY: CGFloat = 0.0) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = Float(fade)
        self.layer.shadowRadius = distance
        self.layer.shadowOffset = CGSize(width: offX, height: offY)
    }
    
    // currently focused view item (eg UITextField)
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }

}
