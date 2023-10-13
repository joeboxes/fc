//
//  UIView+Extensions.swift
//  

import UIKit
import Foundation

extension UIImage {
    
    static func imageWithTint(_ image: UIImage, _ tintColor: UIColor) -> UIImage {
        let originalImage = image
        let templateImage = originalImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let imageSize = templateImage.size
        UIGraphicsBeginImageContextWithOptions(imageSize, false, templateImage.scale)
        
        tintColor.set()
        templateImage.draw(in: CGRect(origin: .zero, size:imageSize))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
