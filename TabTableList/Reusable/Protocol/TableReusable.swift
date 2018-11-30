//
//  TableReusable.swift
//  PublicView
//
//  Created by ycpeng on 2018/4/4.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

// MARK: - cell
public protocol TableReusable {
    //当前包含适配数据
    var viewItem: TableReusableViewItem? { get }
    
    //显示内容
    func willShow(viewItem: TableReusableViewItem)
}

public typealias TableNibReusable = TableReusable & NibLoadable
