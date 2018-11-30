//
//  TabScrollView.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/20.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit

class TabScrollView: UIScrollView {
    override var contentOffset: CGPoint {
        didSet {
            if contentOffset.y != oldValue.y {
                if privateDelegate.syncScrollContext.innerOffset.y > 0 {
                    contentOffset.y = privateDelegate.syncScrollContext.maxOffsetY
                }
                privateDelegate.syncScrollContext.outerOffset = contentOffset
            }
        }
    }
    
    override var frame: CGRect {
        didSet {
            if !frame.size.equalTo(oldValue.size) {
                p_layoutSubviews()
            }
        }
    }
    
    override var bounds: CGRect {
        didSet {
            if !bounds.size.equalTo(oldValue.size) {
                p_layoutSubviews()
            }
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            p_layoutSubviews()
        }
    }
    
    var headerView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let headerView = headerView {
                addSubview(headerView)
            }
            p_layoutSubviews()
        }
    }
    
    var tabBarView: (UIView & TabScrollViewDelegate)? {
        didSet {
            oldValue?.removeFromSuperview()
            if let tabBarView = tabBarView {
                addSubview(tabBarView)
            }
            p_layoutSubviews()
            tabBarView?.indexChangedClosure = { [weak self] (index,animation) in
                if let count = self?.collectionView.numberOfItems(inSection: 0),
                    0..<count ~= index {
                    self?.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: animation)
                }
            }
            privateDelegate.delegate = tabBarView
        }
    }
    
    private var privateDelegate: TabScrollViewPrivateDelegate = TabScrollViewPrivateDelegate()
    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = CGSize.zero
        flowLayout.footerReferenceSize = CGSize.zero
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.dataSource = privateDelegate
        collectionView.delegate = privateDelegate
        collectionView.bounces = false
        collectionView.bouncesZoom = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TabVCCollectionViewCell.self, forCellWithReuseIdentifier: "TabVCCollectionViewCell")
        addSubview(collectionView)
        return collectionView
    }()
    
    weak var vcDelegate: TabScrollViewViewControllerDelegate? {
        set {
            privateDelegate.vcDelegate = newValue
        }
        get {
            return privateDelegate.vcDelegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultConfig()
        
    }
    
    private func defaultConfig() {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        bounces = false
        bouncesZoom = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    private func p_layoutSubviews() {
        var offsetY: CGFloat = 0
        if let headerView = headerView {
            headerView.frame = CGRect(x: 0, y: offsetY, width: bounds.width, height: headerView.frame.height)
            offsetY += headerView.frame.height
            privateDelegate.syncScrollContext.maxOffsetY = headerView.frame.height - contentInset.top
        }
        if let tabBarView = tabBarView {
            tabBarView.frame = CGRect(x: 0, y: offsetY, width: bounds.width, height: tabBarView.frame.height)
            offsetY += tabBarView.frame.height
        }
        let tabBarViewHeight: CGFloat = tabBarView?.frame.height ?? 0
        collectionView.frame = CGRect(x: 0, y: offsetY, width: bounds.width, height: bounds.height - tabBarViewHeight - contentInset.top)
        flowLayout.itemSize = collectionView.bounds.size
        collectionView.reloadData()
        contentSize = CGSize(width: bounds.width, height: collectionView.frame.maxY)
        contentOffset.y = -contentInset.top
    }
}

/// 隐藏部分实现
///
/// 此处UICollectionView的协议不采用扩展写法，否则会暴露在头文件中
private class TabScrollViewPrivateDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    typealias ScrollViewScrollBlock = (UIScrollView) -> Void
    
    var scrollViewDidScrollBlock: ScrollViewScrollBlock?
    var scrollViewWillBeginDraggingBlock: ScrollViewScrollBlock?
    var scrollViewDidEndDeceleratingBlock: ScrollViewScrollBlock?
    
    weak var delegate: TabScrollViewDelegate?
    weak var vcDelegate: TabScrollViewViewControllerDelegate?
    var syncScrollContext: SyncScrollContext = SyncScrollContext()
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "TabVCCollectionViewCell", for: indexPath)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TabVCCollectionViewCell {
            let childVC = vcDelegate?.childViewController(atIndex: indexPath.item)
            let parentVC: UIViewController? = vcDelegate?.parentViewController()
            cell.viewControllerWillAppear(childVC: childVC, parentVC: parentVC)
            childVC?.scrollableContainer?.syncScrollContext = syncScrollContext
            childVC?.scrollableContainer?.syncContext()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TabVCCollectionViewCell {
            let childVC: UIViewController? = vcDelegate?.childViewController(atIndex: indexPath.item)
            cell.viewControllerWillDisappear(childVC: childVC)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.vcScrollViewDidScroll(scrollView)
    }
}

