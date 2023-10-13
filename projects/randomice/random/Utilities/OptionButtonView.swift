//
//  OptionButtonView.swift
//  

import UIKit

class OptionButtonView: UIView, ButtonEventViewDelegate {
    static let NotificationStarted = Notification.Name("OptionButtonView.NotificationStarted")
    static let NotificationSelected = Notification.Name("OptionButtonView.NotificationSelected")
    static let indexSelectionOptionType = "indexSelectionType"
    static let sharedFeedback = UIImpactFeedbackGenerator(style: .medium)

    var buttonView: ButtonEventView!
    
    private var viewsPressed = [UIView]()
    private var viewsUnpressed = [UIView]()
    private var viewIndex: Int = -1
    private var _displaySize = CGSize(width: 0.0, height: 0.0) // default to fill parent
    var displaySize: CGSize {
        get {
            return _displaySize
        }
        set {
            _displaySize = newValue
            setSizingConstraints(buttonView)
        }
    }
    var feedback = sharedFeedback
    var notificationCenter: NotificationCenter?
    var feedbackOnDown = true
    var feedbackOnUp = false
    var data: Any?
    var maximumTouchDistance: CGFloat {
        get {
            return buttonView.maxiumTouchDistance
        }
        set {
            buttonView.maxiumTouchDistance = newValue
        }
    }
    
    private var isIgnoring = false
    var ignoreOtherGestures: Bool {
        get {
            return isIgnoring
        }
        set(newValue) {
            isIgnoring = newValue
            displayButton()
        }
    }
    
    override init(frame: CGRect) {
        let unpressed = UIImageView()
        viewsUnpressed.append(unpressed)
        viewIndex = 0
        super.init(frame: frame)
        buttonView = ButtonEventView()
//        buttonView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.5)
        buttonView!.delegate = self
        
        displayButton()
        gotoUnpressed()
        feedback.prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUnpressedViews(_ views: [UIView]) {
        viewUnpressed?.removeFromSuperview()
        viewsUnpressed = views
        setActiveIndex(viewIndex)
        setNeedsLayout()
        gotoUnpressed()
    }
    func setPressedViews(_ views: [UIView]) {
        viewPressed?.removeFromSuperview()
        viewsPressed = views
        setActiveIndex(viewIndex)
        setNeedsLayout()
        gotoUnpressed()
    }
    
    
    func setDisplaySize(_ width: CGFloat, _ height: CGFloat) {
        displaySize = CGSize(width: width, height: height)
        setNeedsLayout()
        gotoUnpressed()
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            if displaySize.width == 0 || displaySize.height == 0 {
                return CGSize.zero
            }
            return displaySize
        }
    }
    
    func showFeedback() {
        feedback.impactOccurred()
        feedback.prepare()
    }
    
    private func handleStartTouchSuccess() {
        if feedbackOnDown {
            showFeedback()
        }
        gotoPressed()
        notificationCenter?.post(Notification(name: OptionButtonView.NotificationStarted, object: self, userInfo: nil))
    }
    private func handleCompleteTouchSuccess() {
        if feedbackOnUp {
            showFeedback()
        }
        gotoUnpressed()
        notificationCenter?.post(Notification(name: OptionButtonView.NotificationSelected, object: self, userInfo: nil))
    }
    
    // button view delegates
    func buttonViewDidTouchDown(_ button: ButtonEventView) {
        handleStartTouchSuccess()
    }
    
    func buttonViewDidTouchUpInside(_ button: ButtonEventView) {
        handleCompleteTouchSuccess()
    }
   
    func buttonViewDidTouchUpOutside(_ button: ButtonEventView) {
        //
    }
    func buttonViewDidTouchMoveInside(_ button: ButtonEventView) {
        //
    }
    func buttonViewDidTouchMoveOutside(_ button: ButtonEventView) {
        gotoUnpressed()
    }
    func buttonViewDidCancel(_ button: ButtonEventView) {
        gotoUnpressed()
    }
    
    // button delegates
    @objc func handleButtonPress() {
        handleStartTouchSuccess()
    }
    @objc func handleButtonSelect() {
        handleCompleteTouchSuccess()
    }
    @objc func handleButtonOutside() {
        gotoUnpressed()
    }
    
    // private
    private var viewUnpressed: UIView? {
        get {
            if viewsUnpressed.count > 0 && viewIndex < viewsUnpressed.count  {
                return viewsUnpressed[viewIndex]
            }
            return nil
        }
    }
    private var viewPressed: UIView? {
        if viewsPressed.count > 0 && viewIndex < viewsPressed.count  {
            return viewsPressed[viewIndex]
        } // default to unpressed views
        return viewUnpressed
    }
    
    private func setActiveIndex(_ index: Int) {
        viewIndex = index
        if viewIndex < 0 {
            viewIndex = 0
        }
        if viewIndex >= viewsUnpressed.count {
            viewIndex = viewsUnpressed.count - 1
        }
        gotoUnpressed()
    }
    
    private func setSizingConstraints(_ item: UIView) {
        // fill to size of container
        if displaySize.width == 0 || displaySize.height == 0 {
            item.snp.removeConstraints()
            item.snp.makeConstraints(){ make in
                make.edges.equalToSuperview()
            }
        } else {
            item.snp.removeConstraints()
            item.snp.makeConstraints(){ make in
                make.centerX.centerY.equalToSuperview()
                make.size.equalTo(displaySize)
            }
        }
    }
    
    private func gotoUnpressed() {
        removeExcessSubviews()
        if let unpressed = viewUnpressed {
            insertSubview(unpressed, at: 0)
            setSizingConstraints(unpressed)
        }
    }
    
    private func gotoPressed() {
        removeExcessSubviews()
        if let pressed = viewPressed {
            insertSubview(pressed, at: 0)
            setSizingConstraints(pressed)
        }
    }
    
    private func removeExcessSubviews() {
        for v in subviews {
            if v != buttonView {
                v.removeFromSuperview()
            }
        }
    }
    
    // private 
    private func displayButton() {
        isIgnoring = false
        buttonView.preventsOtherGestures = true
        buttonView.removeFromSuperview()
        addSubview(buttonView)
        setSizingConstraints(buttonView)
    }
    
    static func createIconTextView(_ view: UIView, _ text: String, _ color: UIColor? = nil, _ font: UIFont? = nil) -> UIView {
        var textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        if let _color = color {
            textColor = _color
        }
        let savedImageText = UILabel()
        savedImageText.font = font ?? UIFont(name: "FuturaStd-Medium", size: 12)
        savedImageText.textAlignment = .center
        savedImageText.textColor = textColor
        savedImageText.text = text
        let savedView = UIView()
        savedView.addSubview(view)
        savedView.addSubview(savedImageText)
        view.snp.makeConstraints(){ make in
            make.edges.equalToSuperview()
        }
        savedImageText.snp.makeConstraints(){ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        return savedView
    }
}


