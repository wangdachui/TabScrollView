//
//  SyncScrollTableView.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/19.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit

class SyncScrollTableView: UITableView {
    var syncScrollContext: SyncScrollContext?
    override var contentOffset: CGPoint {
        didSet {
            if contentOffset.y != oldValue.y {
                guard let syncScrollContext = syncScrollContext else { return }
                if syncScrollContext.outerOffset.y < syncScrollContext.maxOffsetY {
                    contentOffset.y = -contentInset.top
                }
                syncScrollContext.innerOffset = contentOffset
            }
        }
    }
}

extension SyncScrollTableView: TabSubScrollViewSyncable {
    func syncContext() {
        guard let syncScrollContext = syncScrollContext else { return }
        if syncScrollContext.outerOffset.y < syncScrollContext.maxOffsetY {
            contentOffset.y = 0 - contentInset.top
        }
        syncScrollContext.innerOffset = contentOffset
    }
}

extension SyncScrollTableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.view is UICollectionView
        || otherGestureRecognizer.view is UICollectionView {
            return false
        }
        return true
    }
}
