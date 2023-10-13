//
//  TextListView.swift
//

import UIKit

class TextListView: UIView {
    
//    var notificationCenter: NotificationCenter!
    
    var titleLabel: UILabel!
    var dotsView: UIImageView!
    private var iconSize: CGFloat = 40.0
    private var textSize: CGFloat = 0.0
    
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
        backgroundColor = AppSettings.colors.themeWhite
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        // TITLE
        titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.textAlignment = .center
        let name = Utilities.appDisplayName()
        titleLabel.text = "\(name)"
        
        // ELLIPSES
        dotsView = UIImageView(image: UIImage(named: "icon_dots"))
        addSubview(dotsView)
        dotsView.isHidden = true
        dotsView.snp.makeConstraints { make in
            make.size.equalTo(iconSize)
            make.right.equalTo(titleLabel.snp.left)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func setDisplayStyle(_ font: UIFont?, _ color: UIColor?) {
        if let _font = font {
            titleLabel.font = _font
        }
        if let _color = color {
            titleLabel.textColor = _color
        }
    }
    
    func setText(_ items: [String], _ maxCheck: Int = 0) {
        let maxWidth: CGFloat = frame.size.width - iconSize - 10.0 // padding
        var str = ""
        var skipped = false
        for item in items {
            let next = "\(item) \(str)"
            let size = UILabel.minWidthForString(next, titleLabel.font)
            if size.width < maxWidth {
                str = next
            } else {
                skipped = true
                break
            }
        }
        titleLabel.text = str
        let size = UILabel.minWidthForString(str, titleLabel.font)
        textSize = size.width
        let showDots = (items.count > 0 && skipped) || (maxCheck > 0 && items.count == maxCheck)
        if showDots {
            dotsView.isHidden = false
            titleLabel.snp.remakeConstraints { make in
                make.width.equalTo(textSize)
                make.height.equalToSuperview()
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview().offset(iconSize*0.5)
            }
        } else {
            dotsView.isHidden = true
            titleLabel.snp.remakeConstraints { make in
                make.width.equalTo(textSize)
                make.height.equalToSuperview()
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
            }
        }
        setNeedsLayout()
    }
    
}

