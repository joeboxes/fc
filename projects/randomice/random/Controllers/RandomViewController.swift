//
//  RandomViewController.swift
//

import UIKit
// import SnapKit

class RandomViewController: FocusableController {
    
    let randomView = RandomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(randomView)
        randomView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        randomView.updateDisplays()
    }
    
    override func didGetFocus(_ context: Any?) {
        super.didGetFocus(context)
        addListeners()
        randomView.addListeners()
    }
    override func didLoseFocus(_ context: Any?) {
        super.didLoseFocus(context)
        randomView.removeListeners()
        removeListeners()
    }
    
    func addListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeListeners() {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    private var keyboardHeight: CGFloat = 0.0
    
    @objc func handleNotification(notification: Notification) {
        if notification.name == UIResponder.keyboardWillChangeFrameNotification {
            if let keyboardRectangle = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let root: UIView! = UIApplication.shared.windows[0].rootViewController?.view
                let rect = root.convert(keyboardRectangle, to: self.view)
                keyboardHeight = max(0, self.view.frame.size.height - rect.origin.y)
                // let duration: TimeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.0
            }

            
            let first = view.firstResponder
            if keyboardHeight > 0 { // keyboard appearing
                let delta = (view.frame.size.height - keyboardHeight)*0.5 - first!.center.y  // TODO: TRANSFORM CENTER POINT INTO LOCAL COORDS
                randomView.transform = CGAffineTransform.init(translationX: 0.0, y: delta)
            } else {
                randomView.transform = .identity
            }
        }
    }
    
    deinit {
        //
    }
}

