//
//  TabVCCollectionViewCell.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/19.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit

class TabVCCollectionViewCell: UICollectionViewCell {
    func viewControllerWillAppear(childVC: UIViewController?, parentVC: UIViewController?) {
        guard let parentVC = parentVC, let childVC = childVC else { return }
        parentVC.addChild(childVC)
        childVC.view.frame = bounds
        contentView.addSubview(childVC.view)
        childVC.didMove(toParent: parentVC)
    }
    
    func viewControllerWillDisappear(childVC: UIViewController?) {
        guard let childVC = childVC else { return }
        childVC.willMove(toParent: nil)
        childVC.removeFromParent()
        childVC.view.removeFromSuperview()
    }
}
