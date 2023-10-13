//
//  AboutView.swift
//

import UIKit

class AboutView: UIView {
    
    var notificationCenter: NotificationCenter!
    
    var rootView: UIView!
    var titleLabel: UILabel!
    var versionLabel: UILabel!
    var buttonBack: OptionButtonView!
    
    // APP LOGO ?
    
    // APP STORE LINK ?
    
    // DESCRIPTION INFO ?
    
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
        notificationCenter = NotificationCenter()
        
        let insetTop: CGFloat = Utilities.deviceFullScreenPaddingTop()
        let insetBot: CGFloat = Utilities.deviceFullScreenPaddingBottom()
        
        let borderOutside: CGFloat = 10.0
        
        backgroundColor = AppSettings.views.root.backgroundColor
        
        var imageView: UIImageView!
        
        // ROOT
        rootView = UIView()
        addSubview(rootView)
        rootView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(insetTop)
            make.bottom.equalToSuperview().offset(-insetBot)
        }
        
        // TITLE
        titleLabel = UILabel()
        rootView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(borderOutside)
            make.height.equalTo(56)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = AppSettings.views.about.title.font
        titleLabel.textColor = AppSettings.views.about.title.color
        let name = Utilities.appDisplayName()
        titleLabel.text = "\(name)"
        
        // VERSION
        versionLabel = UILabel()
        rootView.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(borderOutside)
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            make.height.equalTo(32)
        }
        versionLabel.textAlignment = .center
        versionLabel.font = AppSettings.views.about.version.font
        versionLabel.textColor = AppSettings.views.about.version.color
        let version = Utilities.appVersionNumber()
        versionLabel.text = "\(version)"
        
        // BACK
        buttonBack = OptionButtonView()
        rootView.addSubview(buttonBack)
        buttonBack.notificationCenter = notificationCenter
        imageView = UIImageView(image: UIImage(named:"button_back"))
        buttonBack.setUnpressedViews([imageView])
        imageView = UIImageView(image: UIImage(named:"button_back_down"))
        buttonBack.setPressedViews([imageView])
        buttonBack.displaySize = AppSettings.sizes.buttonLarge
        buttonBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(borderOutside)
            make.bottom.equalToSuperview().offset(-borderOutside)
            make.size.equalTo(AppSettings.sizes.buttonLarge)
        }
        
    }
    
    @objc func handleNotificationButton(notification: Notification) {
        if let button = notification.object as? OptionButtonView {
            if notification.name == OptionButtonView.NotificationSelected {
                if button == buttonBack {
                    NavigationController.requestShowRandomView()
                }
            }
        }
    }
    
    func addListeners() {
        notificationCenter.addObserver(self, selector: #selector(handleNotificationButton), name: OptionButtonView.NotificationSelected, object: nil)
    }
    
    func removeListeners() {
        notificationCenter.removeObserver(self)
    }

}

