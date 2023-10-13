//
//  RandomView.swift
//

import UIKit
// import SnapKit

protocol AutoCollectionControllerDelegate: class {
    func collectionRegisterCells(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ data: Any?)
    func collectionCellForData(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ index: Int, _ data: Any?) -> UICollectionViewCell?
    func collectionSizeForData(_ collection: AutoCollectionController, _ collectionView: UICollectionView, _ index: Int, _ data: Any?) -> CGSize?
    /*
     func collectionDidScroll(_ collection: CollectionItemsController, _ delta: CGPoint)
     func collectionDidScrollToBeginning(_ collection: CollectionItemsController)
     func collectionDidScrollToEnd(_ collection: CollectionItemsController)
     func collectionDidSelectItem(_ collection: CollectionItemsController, _ index: Int, _ item: Any)
     func collectionHeadingRegisterCell(_ collection: CollectionItemsController, _ collectionView: UICollectionView, _ item: Any?)
     func collectionHeadingItem(_ collection: CollectionItemsController, _ index: Int, _ item: Any?) -> UICollectionViewCell?
     func collectionHeadingItemSize(_ collection: CollectionItemsController, _ index: Int, _ item: Any?) -> CGSize?
     func collectionDidScrollPastBeginning(_ collection: CollectionItemsController)
     func collectionDidScrollPastEnd(_ collection: CollectionItemsController)
     */
}

class AutoCollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
   
    private let notificationCenter = NotificationCenter()
    private var loadingView: UIView?
    private var collectionView: UICollectionViewInternal!
    private var collectionLayout: UICollectionViewFlowLayout!
    weak var delegate: AutoCollectionControllerDelegate?
    
    private var collectionBounces = false
    var bounces: Bool {
        get {
            return collectionBounces
        }
        set {
            collectionBounces = newValue
            collectionView?.bounces = collectionBounces
        }
    }
    
    private var cellLineSpacing: CGFloat = 0.0
    var lineSpacing: CGFloat {
        get {
            return cellLineSpacing
        }
        set (newValue) {
            cellLineSpacing = newValue
            if collectionLayout != nil {
                collectionLayout.minimumLineSpacing = cellLineSpacing
            }
        }
    }
    
    private var cellSizeSpacing: CGFloat = 0.0
    var cellSpacing: CGFloat{
        get {
            return cellLineSpacing
        }
        set (newValue) {
            cellSizeSpacing = newValue
            if collectionLayout != nil {
                collectionLayout.minimumInteritemSpacing = cellSizeSpacing
            }
        }
    }
    
    private var dataObjects = NSArray()
    func setDataObjects(_ objects: NSArray, _ scrollIndex: Int = 0, _ complete: (()->Void)? = nil, animated: Bool = false) {
//        stopAllCurrentCells()
//        focusedCell = nil
        // swapInController
        dataObjects = objects
        if collectionView != nil {
//            addLoadingView()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
//                self.collectionUpdateCheck()
                if scrollIndex>=0 && objects.count > 0 {
                    self.scrollToItemAtIndex(scrollIndex, animated: animated)
                }
                if let _complete = complete {
                    _complete()
                }
            }
        }
    }
    
    func dataObjectsSource() -> NSArray {
        return dataObjects
    }
    
    func objectAtIndex(_ index: Int) -> Any? {
        if dataObjects.count > index {
            return dataObjects[index]
        }
        return nil
    }
    
    func scrollToItemAtIndex(_ index: Int = 0, _ toTop: Bool = true, animated: Bool = true) {
//        let currentIndexes = collectionView.o
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: toTop ? UICollectionView.ScrollPosition.top : UICollectionView.ScrollPosition.bottom, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collection layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = cellSizeSpacing
        flowLayout.minimumLineSpacing = cellLineSpacing
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionLayout = flowLayout
        
        // collection
        collectionView = UICollectionViewInternal(frame:self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = bounces
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.isOpaque = false
        collectionView.backgroundColor = UIColor.clear
        delegate?.collectionRegisterCells(self, collectionView, nil)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints(){ make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
//        collectionUpdateCheck()
//        addLoadingView()
    }
    
    func registerCell(_ name: String, _ type: AnyClass) {
        collectionView.register(type, forCellWithReuseIdentifier: name)
    }
    
    func cellFrom(_ name: String, _ index: Int) -> UICollectionViewCell {
        let indexPath = IndexPath(row: index, section: 0) 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: name, for: indexPath)
        return cell
    }
    
    func addListeners() {
        removeListeners()
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: VideoController.NotificationVideoUserSelectNext, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: VideoController.NotificationVideoUserSelectPrevious, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: AppController.NotificationPictureInPictureVideoRemoveComplete, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: VideoController.NotificationVideoEnded, object: nil)
    }
    
    func removeListeners() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        removeListeners()
    }
    
    //
    private let headingCellCount: Int = 0
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataObjects.count + headingCellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let data = objectAtIndex(index)
        if let cell = delegate?.collectionCellForData(self, collectionView, index, data) {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let index = indexPath.row
        let data = objectAtIndex(index)
        if let size = delegate?.collectionSizeForData(self, collectionView, index, data) {
            return size
        }
        return CGSize.zero
        
    }
}

