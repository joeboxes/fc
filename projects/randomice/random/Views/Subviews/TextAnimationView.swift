//
//  TextAnimationView.swift
//

import UIKit

class TextAnimationView: UIView {
    
//    var notificationCenter: NotificationCenter!
    
    var titleLabel: UILabel!
    
    init() {
        super.init(frame: CGRect.zero)
        setupAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAll() {
//        notificationCenter = NotificationCenter()
        
        // TITLE
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.text = ""
    }
    func from(_ other: TextAnimationView){
        setText(other.titleLabel.text ?? "", other.titleLabel.font, other.titleLabel.textColor)
    }
    func setText(_ text: String, _ font: UIFont?, _ color: UIColor?) {
        if let _font = font {
            titleLabel.font = _font
        }
        if let _color = color {
            titleLabel.textColor = _color
        }
        titleLabel.text = text
        let size = UILabel.minWidthForString(text, titleLabel.font)
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        titleLabel.frame = frame
        invalidateIntrinsicContentSize()
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return titleLabel.frame.size
        }
    }
    
    func animateBounceIn(_ complete: (()->())? = nil) {
        UIView.animateKeyframes(withDuration: 0.30, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.00, relativeDuration: 0.10, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                self.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.30, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.25, y: 1.25)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.35, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
        }) { finish in
            if let _complete = complete {
                _complete()
            }
        }
    }
    
    func animateFadeOut(_ complete: (()->())? = nil) {
        self.alpha = 1.0
        let down = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8).translatedBy(x: 0.0, y: 100.0)
        UIView.animate(withDuration: 0.30, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.alpha = 0.0
            self.transform = down
        }) { finish in
            if let _complete = complete {
                _complete()
            }
        }
        
    }
    
}

