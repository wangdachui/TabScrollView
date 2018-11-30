//
//  TabChildViewController.swift
//  TabScrollView
//
//  Created by ycpeng on 2018/11/19.
//  Copyright © 2018 ycpeng. All rights reserved.
//

import UIKit

class TabChildViewController: UIViewController, TabScrollViewSyncable {
    var scrollableContainer: TabSubScrollViewSyncable? {
        return tableView
    }
    
    var tableView: SyncScrollTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = {
            let tableView = SyncScrollTableView(frame: view.bounds)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            
            if #available(iOS 11.0, *) {
                tableView.contentInsetAdjustmentBehavior = .never
            }
            
            view.addSubview(tableView)
            return tableView
        }()
        
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

extension TabChildViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.white
        cell.textLabel?.text = "\(indexPath.row)"
        cell.selectionStyle = .none
        return cell
    }
}
