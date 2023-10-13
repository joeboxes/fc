//
//  PopUpController.swift
//

import Foundation
import UIKit

class PopUpController: FocusableController {
    
    private var containerView: UIView!
    
    func setup(_ title: String?, _ description: String?, _options: [String]?, _ views: [UIImageView], _ actions: [()->()]?) {
        
    }
    
    func addOption() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let paddingOutside: CGFloat = 10.0
        
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.80)
        containerView = UIView()
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(paddingOutside)
            make.right.equalToSuperview().offset(-paddingOutside)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
    }
    
}
