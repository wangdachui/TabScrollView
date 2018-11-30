//
//  CollectionReusable.swift
//  PublicView
//
//  Created by ycpeng on 2018/4/4.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

// MARK: - collectionView
public protocol CollectionReusable {
    //当前包含适配数据
    var viewItem: CollectionReusableViewItem? { get }
    
    //显示内容
    func willShow(viewItem: CollectionReusableViewItem)
}

public typealias CollectionNibReusable = CollectionReusable & NibLoadable
