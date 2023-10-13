//
//  ButtonEventView.swift
//

import UIKit
// import SnapKit

class UICollectionViewInternal: UICollectionView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
        if let _ = otherGestureRecognizer as? UISwipeGestureRecognizer {
            return true
        }
        return false
    }
}
