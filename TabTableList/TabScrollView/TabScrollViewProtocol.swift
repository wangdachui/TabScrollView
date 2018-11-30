//
//  TabScrollViewProtocol.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/20.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit

/// TabScrollView里面同步滑动的ScrollView需要实现的协议
///
/// 推荐使用SyncScrollTableView或SyncScrollCollectionView
protocol TabSubScrollViewSyncable: class {
    var contentOffset: CGPoint { get set }
    var syncScrollContext: SyncScrollContext? { get set }
    func syncContext()
}

/// 获取TabScrollView里面同步滑动的ScrollView的协议
protocol TabScrollViewSyncable: class {
    var scrollableContainer: TabSubScrollViewSyncable? { get }
}

/// 获取ViewController的代理
protocol TabScrollViewViewControllerDelegate: class {
    func childViewController(atIndex index: Int) -> UIViewController & TabScrollViewSyncable
    func parentViewController() -> UIViewController
}

/// 获取数据源的代理
protocol TabScrollViewDelegate: class {
    var indexChangedClosure: ((Int,Bool) -> Void)? { get set }
    
    func defaultIndex(index: Int)
    func numberOfItems() -> Int
    func vcScrollViewDidScroll(_ scrollView: UIScrollView)
}
