//
//  AboutViewController.swift
//

import UIKit
import SnapKit

class AboutViewController: FocusableController {
    
    var aboutView: AboutView!
    
    override func didGetFocus(_ context: Any?) {
        super.didGetFocus(context)
        aboutView.addListeners()
    }
    
    override func didLoseFocus(_ context: Any?) {
        super.didLoseFocus(context)
        aboutView.removeListeners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        aboutView = AboutView()
        view.addSubview(aboutView)
        aboutView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        // 
    }
}

