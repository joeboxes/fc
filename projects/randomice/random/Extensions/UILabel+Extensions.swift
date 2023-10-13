//
//  UIabel+Extensions.swift
//  

import UIKit
import Foundation

extension UILabel {
    
    static func sizeLabelForString(_ label: UILabel, _ str: String? = nil, font: UIFont? = nil) -> Void {
        let inFont: UIFont = font ?? label.font
        let inString: String = str ?? (label.text ?? "")
        let size = minWidthForString(inString, inFont)
        var rect = label.frame
        rect.size.width = size.width
        rect.size.height = size.height
        label.frame = rect
    }
    
    static func minWidthForString(_ str: String, _ font: UIFont) -> CGSize {
        let nsStr = NSString(string:str)
        let size = CGSize(width: 99999, height: 999)
        let rect = nsStr.boundingRect(with: size, options: NSStringDrawingOptions(rawValue: 0), attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
    
    static func heightLabelForString(_ label: UILabel, _ str: String? = nil, font: UIFont? = nil, _ width: CGFloat? = nil) -> Void {
        let inFont: UIFont = font ?? label.font
        let inString: String = str ?? (label.text ?? "")
        let inWidth: CGFloat = width ?? label.frame.size.width
        label.font = inFont
        label.text = inString
        label.frame.size.width = inWidth
        label.frame.size.height = 99999
        label.sizeToFit()
    }
    
}

