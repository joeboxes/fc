//
//  ButtonEventView.swift
//

import UIKit
// import SnapKit

protocol ButtonEventViewDelegate: class {
    func buttonViewDidTouchDown(_ button: ButtonEventView) // inside implied
    func buttonViewDidTouchUpInside(_ button: ButtonEventView)
    func buttonViewDidTouchUpOutside(_ button: ButtonEventView)
    func buttonViewDidTouchMoveInside(_ button: ButtonEventView)
    func buttonViewDidTouchMoveOutside(_ button: ButtonEventView)
    func buttonViewDidCancel(_ button: ButtonEventView)
}

class ButtonEventView: UIView {
    weak var delegate: ButtonEventViewDelegate?
    private var hasMovedOutside = false
    private var wasInside = false
    var preventsOtherGestures = false
    var maxiumTouchDistance: CGFloat = 50.0 // 10.0 too low
    
    var startLocation = CGPoint()
    private var hasCanceled = false
    
    var touchesAlwaysInside: Bool {
        get {
            return !hasMovedOutside
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        hasCanceled = false
        hasMovedOutside = false
        wasInside = true
        delegate?.buttonViewDidTouchDown(self)
        for touch in touches {
            startLocation = touch.location(in: window) // TODO: should probably be root view
            break
        }
    }
    private func cancelGRs(_ v: UIView) {
        for sub in v.subviews {
            if let gr = sub.gestureRecognizers {
                for g in gr {
                    if g.isEnabled { // stop the gathering phases
                        g.isEnabled = false
                        g.isEnabled = true
                    }
                }
            }
            cancelGRs(sub)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if hasCanceled {
            return
        }
        for touch in touches {
            // touch-estimation check
            var location = touch.location(in: window) // TODO: should probably be root view
            let delta = CGPoint.sub(location,startLocation)
            let diff = delta.length()
            if maxiumTouchDistance > 0 && diff > maxiumTouchDistance {
                hasCanceled = true
                delegate?.buttonViewDidCancel(self)
                return
            }
            
            location = touch.location(in: superview)
            
            let isInsideX = frame.origin.x <= location.x && location.x <= frame.origin.x + frame.size.width
            let isInsideY = frame.origin.y <= location.y && location.y <= frame.origin.y + frame.size.height
            let isInside = isInsideX && isInsideY
            
            if wasInside && !isInside {
                delegate?.buttonViewDidTouchMoveOutside(self)
            }
            if !wasInside && isInside {
                delegate?.buttonViewDidTouchMoveInside(self)
            }
            hasMovedOutside = hasMovedOutside || !isInside
            wasInside = isInside
            
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if hasCanceled {
            return
        }
        
        for touch in touches {
            let location = touch.location(in: window)
            let delta = CGPoint.sub(location,startLocation)
            let diff = delta.length()
            if maxiumTouchDistance > 0 && diff > maxiumTouchDistance {
                hasCanceled = true
                delegate?.buttonViewDidCancel(self)
                return
            }
            
        }
        if wasInside {
            delegate?.buttonViewDidTouchUpInside(self)
        } else {
            delegate?.buttonViewDidTouchUpOutside(self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        hasCanceled = true
        delegate?.buttonViewDidCancel(self)
    }
}
