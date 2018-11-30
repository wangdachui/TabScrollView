//
//  TableReusableViewItem.swift
//  PublicView
//
//  Created by ycpeng on 2018/4/4.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

// MARK: - 数据源
public protocol TableReusableViewItem {
    /// 视图高度
    var viewHeight: CGFloat { get }
}
