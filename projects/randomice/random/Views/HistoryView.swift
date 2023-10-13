//
//  HistoryView.swift
//

import UIKit

class HistoryView: UIView {
    static let NotificationEventBack = Notification.Name("HistoryView.NotificationEventBack")
    static let NotificationEventClear = Notification.Name("HistoryView.NotificationEventClear")
    static let NotificationEventToggleRepeat = Notification.Name("HistoryView.NotificationEventToggleRepeat")
    static let NotificationEventChangeSorting = Notification.Name("HistoryView.NotificationEventChangeSorting")
    
    static let OrderTypeDefault: Int = 0
    static let OrderTypeTime: Int = 1
    static let OrderTypeNumeric: Int = 2
    
    var notificationCenter: NotificationCenter!
    private var internalNotificationCenter: NotificationCenter!
    
    var buttonOrderTime: OptionButtonView!
    var buttonOrderNumeric: OptionButtonView!
    var buttonBack: OptionButtonView!
    var buttonClear: OptionButtonView!
    var buttonToggleRepeat: OptionButtonView!
    var buttonToggleNoRepeat: OptionButtonView!
    
    var totalLabel: UILabel!
    
    var rootView: UIView!
    var topContainerView: UIView!
    var bottomContainerView: UIView!
    var contentContainerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAll()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAll() {
        internalNotificationCenter = NotificationCenter()
        
        let insetTop: CGFloat = Utilities.deviceFullScreenPaddingTop()
        let insetBot: CGFloat = Utilities.deviceFullScreenPaddingBottom()
        
        let sizeTop: CGFloat = 100.0
        let sizeBottom: CGFloat = 100.0
        
        let borderOutside: CGFloat = 10.0
        
        backgroundColor = AppSettings.views.root.backgroundColor
        
        // ROOT
        rootView = UIView()
        addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(insetTop)
            make.bottom.equalToSuperview().offset(-insetBot)
        }
        
        // CONTENT
        contentContainerView = UIView()
        rootView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(sizeTop)
            make.bottom.equalToSuperview().offset(-sizeBottom)
        }
        
        // TOP
        topContainerView = UIView()
        rootView.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(sizeTop)
        }
        
        // BOT
        bottomContainerView = UIView()
        rootView.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(sizeBottom)
        }
        
        var imageView: UIImageView!
        
        // ORDER TIME
        buttonOrderTime = OptionButtonView()
        topContainerView.addSubview(buttonOrderTime)
        buttonOrderTime.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_order_time"))
        buttonOrderTime.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_order_time_down"))
        buttonOrderTime.setPressedViews([imageView])
        buttonOrderTime.displaySize = AppSettings.sizes.buttonLarge
        buttonOrderTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(borderOutside)
            make.centerY.equalToSuperview().offset(0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // ORDER NUMERIC
        buttonOrderNumeric = OptionButtonView()
        topContainerView.addSubview(buttonOrderNumeric)
        buttonOrderNumeric.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_order_numeric"))
        buttonOrderNumeric.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_order_numeric_down"))
        buttonOrderNumeric.setPressedViews([imageView])
        buttonOrderNumeric.displaySize = AppSettings.sizes.buttonLarge
        buttonOrderNumeric.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-borderOutside)
            make.centerY.equalToSuperview().offset(0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // TOTAL
        totalLabel = UILabel()
        topContainerView.addSubview(totalLabel)
        totalLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(0)
        }
        totalLabel.textColor = AppSettings.views.history.total.color
        totalLabel.font = AppSettings.views.history.total.font
        
        // BACK
        buttonBack = OptionButtonView()
        bottomContainerView.addSubview(buttonBack)
        buttonBack.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_back"))
        buttonBack.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_back_down"))
        buttonBack.setPressedViews([imageView])
        buttonBack.displaySize = AppSettings.sizes.buttonLarge
        buttonBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(borderOutside)
            make.centerY.equalToSuperview().offset(0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // REPEAT
        buttonToggleRepeat = OptionButtonView()
        bottomContainerView.addSubview(buttonToggleRepeat)
        buttonToggleRepeat.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_repeat_on"))
        buttonToggleRepeat.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_repeat_on_down"))
        buttonToggleRepeat.setPressedViews([imageView])
        buttonToggleRepeat.displaySize = AppSettings.sizes.buttonLarge
        buttonToggleRepeat.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-borderOutside)
            make.centerY.equalToSuperview().offset(0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        buttonToggleRepeat.isHidden = true
        
        // NON-REPEAT
        buttonToggleNoRepeat = OptionButtonView()
        bottomContainerView.addSubview(buttonToggleNoRepeat)
        buttonToggleNoRepeat.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_repeat_off"))
        buttonToggleNoRepeat.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_repeat_off_down"))
        buttonToggleNoRepeat.setPressedViews([imageView])
        buttonToggleNoRepeat.displaySize = AppSettings.sizes.buttonLarge
        buttonToggleNoRepeat.snp.makeConstraints { make in
            make.edges.equalTo(buttonToggleRepeat)
        }
        buttonToggleNoRepeat.isHidden = true
        
        // CLEAR
        buttonClear = OptionButtonView()
        bottomContainerView.addSubview(buttonClear)
        buttonClear.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_clear"))
        buttonClear.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_clear_down"))
        buttonClear.setPressedViews([imageView])
        buttonClear.displaySize = AppSettings.sizes.buttonLarge
        buttonClear.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
        // to top:
        // insertSubview(contentContainerView, at: 0)
        rootView.insertSubview(contentContainerView, at: subviews.count-1) // WHY IS BEING BELOW STOP INTERACTIONS
        
        updateDisplay()
    }
    
    func addListeners() {
        internalNotificationCenter.addObserver(self, selector: #selector(handleNotificationButton), name: OptionButtonView.NotificationSelected, object: nil)
    }
    
    func removeListeners() {
        internalNotificationCenter.removeObserver(self)
    }
    
    private func updateDisplayRepeat() {
        let repeats = UserPreferencesManager.getUserPrefersNumberRepeat()
        if repeats {
            buttonToggleRepeat.isHidden = false
            buttonToggleNoRepeat.isHidden = true
        } else {
            buttonToggleRepeat.isHidden = true
            buttonToggleNoRepeat.isHidden = false
        }
    }
    
    func updateDisplay() {
        let orderType = UserPreferencesManager.getUserPrefersOrderType()
        if orderType == HistoryView.OrderTypeDefault || orderType == HistoryView.OrderTypeTime {
            // ...
        }
        updateDisplayRepeat()
        let history = UserDataManager.numbers()
        totalLabel.text = "\(history.count)"
        
    }
    
    @objc func handleNotificationButton(notification: Notification) {
        if let button = notification.object as? OptionButtonView {
            if notification.name == OptionButtonView.NotificationSelected {
                if button == buttonOrderTime {
                    let orderType = UserPreferencesManager.getUserPrefersOrderType()
                    if orderType != HistoryView.OrderTypeTime {
                        UserPreferencesManager.setUserPrefersOrderType(HistoryView.OrderTypeTime)
                        notificationCenter?.post(name: HistoryView.NotificationEventChangeSorting, object: self)
//                        updateDisplay()
                    }
                } else if button == buttonOrderNumeric {
                    let orderType = UserPreferencesManager.getUserPrefersOrderType()
                    if orderType != HistoryView.OrderTypeNumeric {
                        UserPreferencesManager.setUserPrefersOrderType(HistoryView.OrderTypeNumeric)
                        notificationCenter?.post(name: HistoryView.NotificationEventChangeSorting, object: self)
                         updateDisplay()
                    }
                } else if button == buttonBack {
                    notificationCenter?.post(name: HistoryView.NotificationEventBack, object: self)
                } else if button == buttonClear {
                    notificationCenter?.post(name: HistoryView.NotificationEventClear, object: self)
                    updateDisplay()
                } else if button == buttonToggleRepeat || button == buttonToggleNoRepeat {
                    UserPreferencesManager.toggleUserPrefersNumberRepeat()
                    updateDisplayRepeat()
                }
            } else if notification.name == OptionButtonView.NotificationStarted {
                //
            }
        }
    }
    
    private var _contentView: UIView?
    func contentView(_ content: UIView?) {
        _contentView?.removeFromSuperview()
        if let c = content {
            _contentView = c
            contentContainerView.addSubview(c)
            c.snp.removeConstraints()
            c.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }


}

