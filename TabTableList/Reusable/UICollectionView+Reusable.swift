//
//  CollectionReusable.swift
//  PublicView
//
//  Created by ycpeng on 2018/4/4.
//  Copyright © 2018年 yang. All rights reserved.
//

import UIKit

/// Reusable support for UICollectionView
public extension UICollectionView {
    
    // MARK: - UICollectionViewCell
    final func register<T: UICollectionViewCell, ITEM: CollectionReusableViewItem>(cellType: T.Type, itemType: ITEM.Type) where T: CollectionNibReusable {
        register(cellType.nib, forCellWithReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func register<T: UICollectionViewCell, ITEM: CollectionReusableViewItem>(cellType: T.Type, itemType: ITEM.Type) where T: CollectionReusable {
        register(cellType.self, forCellWithReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func dequeueReusableCell(item: CollectionReusableViewItem, for indexPath: IndexPath) -> UICollectionViewCell & CollectionReusable {
        let identifier = String(describing: type(of: item))
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! (UICollectionViewCell & CollectionReusable)
    }
    
    // MARK: - UICollectionReusableView
    final func register<T: UICollectionReusableView, ITEM: CollectionReusableViewItem>(supplementaryViewType: T.Type, itemType: ITEM.Type, ofKind elementKind: String) where T: CollectionNibReusable {
        register(supplementaryViewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func register<T: UICollectionReusableView, ITEM: CollectionReusableViewItem>(supplementaryViewType: T.Type, itemType: ITEM.Type, ofKind elementKind: String) where T: CollectionReusable {
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: ITEM.self))
    }
    
    final func dequeueReusableSupplementaryView(ofKind elementKind: String, item: CollectionReusableViewItem, for indexPath: IndexPath) -> UICollectionReusableView & CollectionReusable {
        let identifier = String(describing: type(of: item))
        return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: indexPath) as! (UICollectionReusableView & CollectionReusable)
    }
}
