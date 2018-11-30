//
//  ViewController.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/19.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift
import ReactiveCocoa
import ReactiveSwift

class ViewController: UIViewController {
    
    var tabScrollView: TabScrollView!
    var childVCDic: [Int: TabChildViewController] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabScrollView = {
            let tabScrollView = TabScrollView(frame: view.bounds)
            tabScrollView.vcDelegate = self
            view.addSubview(tabScrollView)
            return tabScrollView
        }()
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100.0))
        headerView.backgroundColor = .red
        tabScrollView.headerView = headerView
        tabScrollView.tabBarView = tabBarView()
        
        tabScrollView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(C.Distance.navBarHeightWithSafeArea)
            maker.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func tabBarView()-> TabBarView {
        let tabBarView = TabBarView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50), titles: ["零钱","金币"])
        return tabBarView
        
    }
}

extension ViewController: TabScrollViewViewControllerDelegate {
    
    func childViewController(atIndex index: Int) -> UIViewController & TabScrollViewSyncable {
        if let vc = childVCDic[index] {
            return vc
        } else {
            let vc: TabChildViewController = TabChildViewController()
            vc.title = "title\(index)"
            childVCDic[index] = vc
            return vc
        }
    }
    
    func parentViewController() -> UIViewController {
        return self
    }
}
