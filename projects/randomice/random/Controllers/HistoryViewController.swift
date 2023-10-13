//
//  HistoryViewController.swift
//

import UIKit
// import SnapKit

class HistoryViewController: FocusableController, AutoCollectionControllerDelegate {
    static let CELL_ID_NUMBER = "number"
    
    var notificationCenter: NotificationCenter!
    var collection: AutoCollectionController!
    var history: HistoryView!
    
    override func didGetFocus(_ context: Any?) {
        super.didGetFocus(context)
        history.addListeners()
        addListeners()
    }
    override func didLoseFocus(_ context: Any?) {
        super.didLoseFocus(context)
        history.removeListeners()
        removeListeners()
    }
    
    deinit {
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        notificationCenter = NotificationCenter()
        
        history = HistoryView()
        view.addSubview(history)
        history.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        history.notificationCenter = notificationCenter
        
        
        collection = AutoCollectionController()
        collection.delegate = self
        collection.willMove(toParent: self)
            history.contentView(collection.view)
        self.addChild(collection)
        collection.didMove(toParent: self)
        collection.bounces = true
        
        updateObjectsFromSource()
    }
    
    private func addListeners() {
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: HistoryView.NotificationEventBack, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: HistoryView.NotificationEventClear, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: HistoryView.NotificationEventChangeSorting, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: PopUpConfirmController.NotificationEventIgnore, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: PopUpConfirmController.NotificationEventCancel, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification), name: PopUpConfirmController.NotificationEventConfirm, object: nil)
    }
    
    private func removeListeners() {
        notificationCenter.removeObserver(self)
    }
    
    private var popup: PopUpConfirmController?
    
    @objc func handleNotification(notification: Notification) {
        if notification.name == HistoryView.NotificationEventBack {
            NavigationController.requestShowRandomView()
        } else if notification.name == HistoryView.NotificationEventClear {
            let pup = PopUpConfirmController("Clear?")
            pup.notificationCenter = notificationCenter
            
            pup.willMove(toParent: self)
            addChild(pup)
            view.addSubview(pup.view)
            pup.view.snp.makeConstraints(){ make in
                make.edges.equalToSuperview()
            }
            pup.didMove(toParent: self)
            pup.notificationCenter = notificationCenter
            
            popup = pup
        } else if notification.name == HistoryView.NotificationEventChangeSorting {
            updateOrdering()
        } else if notification.name == PopUpConfirmController.NotificationEventIgnore {
            dropPopup()
        } else if notification.name == PopUpConfirmController.NotificationEventCancel {
            dropPopup()
        } else if notification.name == PopUpConfirmController.NotificationEventConfirm {
            dropPopup()
            let _ = UserDataManager.clearNumbers()
            updateObjectsFromSource()
            history.updateDisplay()
        }
        
    }
    private func dropPopup() {
        popup?.exit()
        popup = nil
    }
    
    private func updateOrdering() {
        let orderType = UserPreferencesManager.getUserPrefersOrderType()
        var historyNumbers: NSArray = UserDataManager.numbers()
        
        if orderType == HistoryView.OrderTypeDefault || orderType == HistoryView.OrderTypeTime {
            // N/A
        } else if orderType == HistoryView.OrderTypeNumeric {
            let list = historyNumbers.sorted(by: { (a, b) -> Bool in
                return (a as! NSNumber).intValue < (b as! NSNumber).intValue ? true : false
            })
            historyNumbers = NSArray(array: list)
        }
        collection.setDataObjects(historyNumbers, 0, nil, animated: true)
    }
    
    private func updateObjectsFromSource() {
        updateOrdering()
    }
    
    func collectionRegisterCells(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ data: Any?) {
        collection.registerCell(HistoryViewController.CELL_ID_NUMBER,NumberViewCell.self)
    }
    func collectionCellForData(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ index: Int, _ data: Any?) -> UICollectionViewCell? {
        let number = (data as! NSNumber).intValue
        let cell = collection.cellFrom(HistoryViewController.CELL_ID_NUMBER, index) as! NumberViewCell
        cell.setFrom("\(number)")
        return cell
    }
    func collectionSizeForData(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ index: Int, _ data: Any?) -> CGSize? {
        let availableWidth = view.frame.size.width
//        let availableHeight = view.frame.size.height
        let width: CGFloat = availableWidth
        let height: CGFloat = 52
        return CGSize(width: width, height: height)
    }
}

