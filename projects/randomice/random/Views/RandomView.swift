//
//  RandomView.swift
//

import UIKit

class RandomView: UIView, UITextFieldDelegate {
    
    var notificationCenter: NotificationCenter?
    private var internalNotificationCenter: NotificationCenter!
    
    var rootView: UIView!
    
    var buttonRefresh: OptionButtonView!
    var buttonInfo: OptionButtonView!
    var buttonUndo: OptionButtonView!
    var buttonMin: OptionButtonView!
    var buttonMax: OptionButtonView!
    var buttonHistory: OptionButtonView!
    var buttonFeature: OptionButtonView!
    var buttonCover: OptionButtonView!
    
    var historyView: TextListView!
    
    var iconMin: UIImageView!
    var iconMax: UIImageView!
    
    var inputTextMin: UITextField!
    var inputTextMax: UITextField!
    var outputTextView: TextAnimationView!
    
    var imageIconMin: OptionButtonView!
    var imageIconMax: OptionButtonView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAll() {
        internalNotificationCenter = NotificationCenter()
        backgroundColor = AppSettings.views.root.backgroundColor
        
        var imageView: UIImageView!
        
        // VISUAL SETTINGS
        let insetTop: CGFloat = Utilities.deviceFullScreenPaddingTop()
        let insetBot: CGFloat = Utilities.deviceFullScreenPaddingBottom()
        
        let borderOutside: CGFloat = 10.0
        let spacingMinMax: CGFloat = 10.0
        let spacingNumberMinMax: CGFloat = 10.0
        let spacingNumberHistory: CGFloat = 10.0
        let historyHeight: CGFloat = 72.0
        
        // ROOT
        rootView = UIView()
        addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(insetTop)
            make.bottom.equalToSuperview().offset(-insetBot)
        }
        
        // HISTORY
        buttonHistory = OptionButtonView()
        rootView.addSubview(buttonHistory)
        buttonHistory.notificationCenter = internalNotificationCenter
        buttonHistory.setUnpressedViews([])
        buttonHistory.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(borderOutside)
            make.width.equalToSuperview().offset(-2.0*borderOutside)
            make.height.equalTo(historyHeight)
            make.centerX.equalToSuperview()
        }
        
        historyView = TextListView()
        rootView.insertSubview(historyView, belowSubview: buttonHistory)
        historyView.snp.makeConstraints { make in
            make.edges.equalTo(buttonHistory)
        }
        historyView.setDisplayStyle(AppSettings.views.random.historyNumber.font, AppSettings.views.random.historyNumber.color)
        
        // REFRESH
        buttonRefresh = OptionButtonView()
        rootView.addSubview(buttonRefresh)
        buttonRefresh.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_reload"))
        buttonRefresh.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_reload_down"))
        buttonRefresh.setPressedViews([imageView])
        buttonRefresh.displaySize = AppSettings.sizes.buttonLarge
        buttonRefresh.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-borderOutside)
            make.centerX.equalToSuperview()
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // INFO
        buttonInfo = OptionButtonView()
        rootView.addSubview(buttonInfo)
        buttonInfo.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_about"))
        buttonInfo.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_about_down"))
        buttonInfo.setPressedViews([imageView])
        buttonInfo.displaySize = AppSettings.sizes.buttonLarge
        buttonInfo.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-borderOutside)
            make.left.equalToSuperview().offset(borderOutside)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // UNDO
        buttonUndo = OptionButtonView()
        rootView.addSubview(buttonUndo)
        buttonUndo.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_undo"))
        buttonUndo.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_undo_down"))
        buttonUndo.setPressedViews([imageView])
        buttonUndo.displaySize = AppSettings.sizes.buttonLarge
        buttonUndo.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-borderOutside)
            make.right.equalToSuperview().offset(-borderOutside)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // NUMBER - BUTTON
        buttonFeature = OptionButtonView()
        rootView.addSubview(buttonFeature)
        buttonFeature.notificationCenter = internalNotificationCenter
        buttonFeature.setUnpressedViews([])
        buttonFeature.snp.makeConstraints { make in
            make.bottom.equalTo(rootView.snp.centerY)
            make.top.equalTo(buttonHistory.snp.bottom).offset(spacingNumberHistory)
            make.width.equalToSuperview().offset(-2.0*borderOutside)
            make.centerX.equalToSuperview()
        }
        
        // NUMBER - TEXT
        outputTextView = TextAnimationView()
        rootView.addSubview(outputTextView)
        outputTextView.snp.makeConstraints { make in
            make.center.equalTo(buttonFeature.snp.center)
        }
        // NUMBER - BUTTON - CONT
        rootView.insertSubview(buttonFeature, aboveSubview: outputTextView)
        
        // MIN
        inputTextMin = UITextField()
        rootView.addSubview(inputTextMin)
        inputTextMin.keyboardType = .numberPad
        inputTextMin.textAlignment = .center
        inputTextMin.font = AppSettings.views.random.inputNumber.font
        inputTextMin.textColor = AppSettings.views.random.inputNumber.color
        inputTextMin.delegate = self
        
        buttonMin = OptionButtonView()
        rootView.addSubview(buttonMin)
        buttonMin.notificationCenter = internalNotificationCenter
        buttonMin.setUnpressedViews([])
        buttonMin.snp.makeConstraints { make in
            make.top.equalTo(rootView.snp.centerY).offset(spacingNumberMinMax)
            make.right.equalTo(rootView.snp.centerX).offset(-spacingMinMax*0.5)
            make.left.equalToSuperview().offset(borderOutside)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        // ICON - MIN
        iconMin = UIImageView(image:UIImage(named: "icon_minimum"))
        rootView.addSubview(iconMin)
        iconMin.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(inputTextMin.snp.bottom).offset(0)
            make.centerX.equalTo(inputTextMin)
        }
        
        // MAX
        inputTextMax = UITextField()
        rootView.addSubview(inputTextMax)
        inputTextMax.keyboardType = .decimalPad
        inputTextMax.textAlignment = .center
        inputTextMax.contentVerticalAlignment = .center
        inputTextMax.contentHorizontalAlignment = .center
        inputTextMax.font = AppSettings.views.random.inputNumber.font
        inputTextMax.textColor = AppSettings.views.random.inputNumber.color
        inputTextMax.delegate = self
        
        buttonMax = OptionButtonView()
        rootView.addSubview(buttonMax)
        buttonMax.notificationCenter = internalNotificationCenter
        buttonMax.setUnpressedViews([])
        buttonMax.snp.makeConstraints { make in
            make.top.equalTo(rootView.snp.centerY).offset(spacingNumberMinMax)
            make.left.equalTo(rootView.snp.centerX).offset(spacingMinMax*0.5)
            make.right.equalToSuperview().offset(-borderOutside)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        // ICON - MIN
        iconMax = UIImageView(image:UIImage(named: "icon_maximum"))
        rootView.addSubview(iconMax)
        iconMax.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(inputTextMax.snp.bottom).offset(0)
            make.centerX.equalTo(inputTextMax)
        }
        
        // MIN TEXT - CONT
        inputTextMin.snp.makeConstraints { make in
            make.center.equalTo(buttonMin)
            make.width.equalTo(buttonMin)
            make.height.equalTo(40)
        }
        // MAX TEXT - CONT
        inputTextMax.snp.makeConstraints { make in
            make.center.equalTo(buttonMax)
            make.width.equalTo(buttonMax)
            make.height.equalTo(40)
        }
        
        // COVER
        buttonCover = OptionButtonView()
        buttonCover.ignoreOtherGestures = true
        addSubview(buttonCover)
        buttonCover.notificationCenter = internalNotificationCenter
        buttonCover.setUnpressedViews([])
        buttonCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        buttonCover.isHidden = true
        buttonCover.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.001)
        
        updateDisplays()
    }
    
    private func addCover() {
        buttonCover.isHidden = false
    }
    
    private func removeCover() {
        buttonCover.isHidden = true
    }
    
    @objc func handleNotificationButton(notification: Notification) {
        if let button = notification.object as? OptionButtonView {
            if notification.name == OptionButtonView.NotificationSelected {
                if button == buttonHistory {
                    NavigationController.requestShowHistoryView()
                } else if button == buttonRefresh {
                    newRandomNumber()
                    updateDisplayHistory()
                } else if button == buttonInfo {
                    NavigationController.requestShowAboutView()
                } else if button == buttonUndo {
                    let _ = UserDataManager.popNumber()
                    animateInOutNumbers()
                    updateDisplayHistory()
                } else if button == buttonMin {
                    inputTextMin.becomeFirstResponder()
                    addCover()
                } else if button == buttonMax {
                    inputTextMax.becomeFirstResponder()
                    addCover()
                } else if button == buttonCover {
                    if inputTextMin.isEditing {
                        inputTextMin.resignFirstResponder()
                    } else if inputTextMax.isEditing {
                        inputTextMax.resignFirstResponder()
                    }
                    removeCover()
                }
            }
        }
    }
    
    private func setFeatureNumberText (_ text: String) { //_ number: Int) {
        outputTextView.setText(text, AppSettings.views.random.featuredNumber.font, AppSettings.views.random.featuredNumber.color)
    }
    
    func addListeners() {
        internalNotificationCenter.addObserver(self, selector: #selector(handleNotificationButton), name: OptionButtonView.NotificationSelected, object: nil)
    }
    
    func removeListeners() {
        internalNotificationCenter.removeObserver(self)
    }
    
    // UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maximumCharacters = 5
        let value = textField.text ?? ""
        // to number:
        let next = NSString(string: value).replacingCharacters(in: range, with: string)
        let number = Int(next) ?? 0
        var trimmed: NSString = NSString(string:"\(number)")
        // to length:
        if trimmed.length > maximumCharacters {
            trimmed = NSString(string: trimmed.substring(to: maximumCharacters))
        }
        // set:
        textField.text = "\(trimmed)"
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // begin
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // end?
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        removeCover()
        handleInputTextUpdate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    private func handleInputTextUpdate() {
        var min = Int(inputTextMin.text ?? "") ?? 0
        var max = Int(inputTextMax.text ?? "") ?? 0
        if max < min {
            let temp = min
            min = max
            max = temp
        }
        UserPreferencesManager.setUserPrefersNumberMin(min)
        UserPreferencesManager.setUserPrefersNumberMax(max)
        updateDisplays()
    }
    
    func updateDisplays() {
        updateDisplayHistory()
        updateDisplayNumber()
        // MIN / MAX
        let min = UserPreferencesManager.getUserPrefersNumberMin()
        let max = UserPreferencesManager.getUserPrefersNumberMax()
        inputTextMin.text = "\(min)"
        inputTextMax.text = "\(max)"
    }
    
    func updateDisplayHistory() {
        let maxCheck = 25
        let history = UserDataManager.numbers()
        let maxIndex = min(maxCheck-1,history.count-1)
        var list = [String]()
        if maxIndex >= 0 {
            for i in 0...maxIndex {
                let value = history.object(at: i) as! NSNumber
                list.append("\(value.intValue)")
            }
        }
        setNeedsLayout()
        historyView.setNeedsLayout()
        historyView.setText(list, maxCheck)
    }
    
    private var hasLayedOut = false
    override func layoutSubviews() {
        super.layoutSubviews()
//        if !hasLayedOut {
            historyView.layoutIfNeeded() // why is this necessary ?
            updateDisplayHistory()
//        }
        hasLayedOut = true
    }
    
    private func updateDisplayNumber() {
        let history = UserDataManager.numbers()
        if history.count > 0 {
            let last = history[0]
            setFeatureNumberText("\(last)")
        } else {
            setFeatureNumberText("-")
        }
    }
    private func animateOutOldNumber() {
        let newView = TextAnimationView()
        rootView.insertSubview(newView, belowSubview: outputTextView)
        newView.snp.makeConstraints { make in
            make.center.equalTo(outputTextView.snp.center)
        }
        newView.from(outputTextView)
        newView.setNeedsLayout()
        newView.layoutIfNeeded()
        newView.animateFadeOut({
            newView.removeFromSuperview()
        })
    }
    private func animateInNewNumber() {
        outputTextView.animateBounceIn()
    }
    private func newRandomNumber() {
        let history = UserDataManager.numbers()
        let min = UserPreferencesManager.getUserPrefersNumberMin()
        let max = UserPreferencesManager.getUserPrefersNumberMax()
        
        let repeating = UserPreferencesManager.getUserPrefersNumberRepeat()
        var num: Int = 0
        var success: Bool = false
        if repeating {
            num = Utilities.randomInt(min, max)
            success = true
        } else {
            (num,success) = Utilities.randomIntNoRepeat(min, max, history)
        }
        if success {
            let _ = UserDataManager.addNumber(num)
            animateInOutNumbers()
            // do some kind of animation - SUCCESS
        } else {
            // do some kind of animation - FAIL [non-repeating failure]
        }
    }
    private func animateInOutNumbers() {
        animateOutOldNumber()
        updateDisplayNumber()
        animateInNewNumber()
    }
    
}

