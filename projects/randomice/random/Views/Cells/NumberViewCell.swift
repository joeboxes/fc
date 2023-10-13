//
//  NumberViewCell.swift
//

import UIKit
import SnapKit

class NumberViewCell: UICollectionViewCell {
    
    var displayTextView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(frame:CGRect(x: 0, y: 0, width: 0, height: 0))
        customInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        displayTextView.text = ""
    }
    
    deinit {
        //
    }
    
    func setFrom(_ title: String) {
        displayTextView.text = title
    }
    
    func customInit() {
        backgroundColor = AppSettings.views.root.backgroundColor
        displayTextView = UILabel()
        displayTextView.font = AppSettings.views.history.number.font
        displayTextView.textColor = AppSettings.views.history.number.color
        displayTextView.textAlignment = .center
        displayTextView.numberOfLines = 1
        contentView.addSubview(displayTextView)
        displayTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}


