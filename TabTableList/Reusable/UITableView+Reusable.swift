//
//  CollectionReusable.swift
//  PublicView
//
//  Created by ycpeng on 2018/4/4.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

/// Reusable support for UITableView
public extension UITableView {
    // MARK: - UITableViewCell
    final func register<T: UITableViewCell, ITEM: TableReusableViewItem>(cellType: T.Type, itemType: ITEM.Type) where T: TableNibReusable {
        register(cellType.nib, forCellReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func register<T: UITableViewCell, ITEM: TableReusableViewItem>(cellType: T.Type, itemType: ITEM.Type) where T: TableReusable {
        register(cellType.self, forCellReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func dequeueReusableCell(item: TableReusableViewItem) -> (UITableViewCell & TableReusable)? {
        let identifier = String(describing: type(of: item))
        return dequeueReusableCell(withIdentifier: identifier) as? (UITableViewCell & TableReusable)
    }
    
    final func dequeueReusableCell(item: TableReusableViewItem, for indexPath: IndexPath) -> UITableViewCell & TableReusable {
        let identifier = String(describing: type(of: item))
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! (UITableViewCell & TableReusable)
    }
    
    // MARK: - UITableViewHeaderFooterView
    final func register<T: UITableViewHeaderFooterView, ITEM: TableReusableViewItem>(headerFooterViewType: T.Type, itemType: ITEM.Type) where T: TableNibReusable {
        register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func register<T: UITableViewHeaderFooterView, ITEM: TableReusableViewItem>(headerFooterViewType: T.Type, itemType: ITEM.Type) where T: TableReusable {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func dequeueReusableHeaderFooterView(item: TableReusableViewItem) -> (UITableViewHeaderFooterView & TableReusable)? {
        let identifier = String(describing: type(of: item))
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as? (UITableViewHeaderFooterView & TableReusable)
    }
}
