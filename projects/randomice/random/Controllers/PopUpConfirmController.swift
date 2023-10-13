//
//  PopUpConfirmController.swift
//

import Foundation
import UIKit

class PopUpConfirmController: FocusableController {
    static let NotificationEventIgnore = Notification.Name("PopUpConfirmController.NotificationEventIgnore")
    static let NotificationEventConfirm = Notification.Name("PopUpConfirmController.NotificationEventConfirm")
    static let NotificationEventCancel = Notification.Name("PopUpConfirmController.NotificationEventCancel")
    
    var notificationCenter: NotificationCenter?
    private var internalNotificationCenter: NotificationCenter!
    
    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var iconCorner: UIImageView!
    
    private var buttonCover: OptionButtonView!
    private var buttonConfirm: OptionButtonView!
    private var buttonCancel: OptionButtonView!
    
    init(_ title: String?) {
        super.init(nibName: nil, bundle: nil)
        alertTitle = title ?? ""
    }
    private var alertTitle: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func exit() {
        removeAllFromParent()
        // anim out
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paddingOutside: CGFloat = 10.0
        
        let totalHeight = 10.0 + 50.0 + 10.0 + Double(AppSettings.sizes.buttonLarge.height) + 10.0
        
        internalNotificationCenter = NotificationCenter()
        var imageView: UIImageView!
        
        // COVER
        buttonCover = OptionButtonView()
        buttonCover.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.80)
        buttonCover.maximumTouchDistance = 0
        view.addSubview(buttonCover)
        buttonCover.notificationCenter = internalNotificationCenter
        buttonCover.setUnpressedViews([])
        buttonCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // CONTAINER
        containerView = UIView()
        containerView.backgroundColor = AppSettings.colors.themeBlack // AppSettings.colors.themeWhite
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 10.0
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = AppSettings.colors.alertBorder.cgColor
        
        // LEFT
        let leftView = UIView()
        containerView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.50)
        }
        
        // RIGHT
        let rightView = UIView()
        containerView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.50)
        }
        
        // TITLE
        titleLabel = UILabel()
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.0)
        }
        titleLabel.textColor = AppSettings.views.alert.title.color
        titleLabel.font = AppSettings.views.alert.title.font
        
        titleLabel.text = alertTitle
        
        // ICON
        iconCorner = UIImageView(image:UIImage(named: "icon_warning"))
        containerView.addSubview(iconCorner)
        iconCorner.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.left.equalToSuperview().offset(10.0)
            make.top.equalToSuperview().offset(10.0)
        }
        
        // CONFIRM
        buttonConfirm = OptionButtonView()
        containerView.addSubview(buttonConfirm)
        buttonConfirm.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_confirm"))
        buttonConfirm.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_confirm_down"))
        buttonConfirm.setPressedViews([imageView])
        buttonConfirm.displaySize = AppSettings.sizes.buttonLarge
        buttonConfirm.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10.0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
            make.centerX.equalTo(leftView)
        }
        
        // CANCEL
        buttonCancel = OptionButtonView()
        containerView.addSubview(buttonCancel)
        buttonCancel.notificationCenter = internalNotificationCenter
        imageView = UIImageView(image: UIImage(named:"button_cancel"))
        buttonCancel.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_cancel_down"))
        buttonCancel.setPressedViews([imageView])
        buttonCancel.displaySize = AppSettings.sizes.buttonLarge
        buttonCancel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10.0)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
            make.centerX.equalTo(rightView)
        }
        
        
        // CONTAINER - CONT
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(paddingOutside)
            make.right.equalToSuperview().offset(-paddingOutside)
            make.centerY.equalToSuperview()
            make.height.equalTo(totalHeight)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addListeners()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeListeners()
    }
    
    func addListeners() {
        internalNotificationCenter.addObserver(self, selector: #selector(handleNotificationButton), name: OptionButtonView.NotificationSelected, object: nil)
    }
    
    func removeListeners() {
        internalNotificationCenter.removeObserver(self)
    }
    
    @objc func handleNotificationButton(notification: Notification) {
        if let button = notification.object as? OptionButtonView {
            if notification.name == OptionButtonView.NotificationSelected {
                if button == buttonCover {
                    notificationCenter?.post(name: PopUpConfirmController.NotificationEventIgnore, object: self)
                } else if button == buttonConfirm {
                    notificationCenter?.post(name: PopUpConfirmController.NotificationEventConfirm, object: self)
                } else if button == buttonCancel {
                    notificationCenter?.post(name: PopUpConfirmController.NotificationEventCancel, object: self)
                }
            }
        }
    }
    
}
