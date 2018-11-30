//
//  TabBarView.swift
//  TabTableList
//
//  Created by 王涛 on 2018/11/27.
//  Copyright © 2018年 ycpeng. All rights reserved.
//

import UIKit

class TabBarView: UIView {
    
    var indexChangedClosure: ((Int, Bool) -> Void)?
    private var titles: [String]
    private var btns: [UIButton] = []
    private lazy var lineView: UIView = {
        let line = UIView()
        let color = UIColor(hexString: "f56958")
        line.backgroundColor = color
        let lineHeight: CGFloat = 3
        let lineWidth: CGFloat = 40
        let lineY: CGFloat = bounds.size.height - line.frame.size.height - 5
        line.frame = CGRect(x: 0, y: lineY, width: lineWidth, height: lineHeight)
        line.layer.cornerRadius = line.height/2
        
        line.layer.shadowColor = color?.cgColor
        line.layer.shadowOpacity = 0.5//不透明度
        line.layer.shadowRadius = 5.0//设置阴影所照射的范围
        line.layer.shadowOffset = CGSize.init(width: 0, height: 0)// 设置阴影的偏移量
        return line
    }()
    
    private var currentIndex: Int = 0 {
        didSet {
            if currentIndex < btns.count {
                btns.forEach { (btn) in
                    btn.isSelected = false
                }
                let selectedBtn = btns[currentIndex]
                selectedBtn.isSelected = true
            }
        }
    }
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        
        let w: CGFloat = frame.size.width/CGFloat(titles.count)
        let h: CGFloat = height
        var x: CGFloat = 0
        for i in 0..<titles.count {
            let btn = customButton(index: i)
            btns.append(btn)
            x = w*CGFloat(i)
            btn.frame = CGRect(x: x, y: 0, width: w, height: h)
            addSubview(btn)
        }
        
        //lineView
        lineView.center = CGPoint(x: w/2, y: lineView.center.y)
        addSubview(lineView)
    }
    
    private func customButton(index: Int) -> UIButton {
        let title = titles[index]
        let btn = UIButton()
        btn.setTitleColor(UIColor(hexString: "4c4c4c"), for: .normal)
        btn.setTitleColor(UIColor.black, for: .selected)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.textAlignment = .center
        btn.tag = index
        btn.addTarget(self, action: #selector(didClickOnTabButton(_:)), for: .touchUpInside)
        return btn
    }
    
    @objc func didClickOnTabButton(_ sender: UIButton) {
        indexChangedClosure?(sender.tag,true)
    }
    
    private func pageViewScroll(progress: CGFloat) {
        let w: CGFloat = width/CGFloat(btns.count)
        let beginCenterX = w/2
        let centerX = beginCenterX + width*progress
        lineView.center = CGPoint(x: centerX, y: lineView.center.y)
    }
}

// MARK: Public Method
extension TabBarView {
    func defaultIndex(index: Int) {
        guard index <= btns.count-1 else {
            return
        }
        indexChangedClosure?(index,false)
    }
}

extension TabBarView: TabScrollViewDelegate {
    
    func numberOfItems() -> Int {
        return titles.count
    }
    
    func vcScrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarScroll(with: scrollView)
    }
    
    private func tabBarScroll(with scrollView: UIScrollView) {
        let w = CGFloat(titles.count)*scrollView.bounds.width
        let offsetX = scrollView.contentOffset.x
        if w > 0, offsetX > 0 {
            let progress: CGFloat = offsetX/w
            pageViewScroll(progress: progress)
            currentIndex = Int(round(offsetX/scrollView.bounds.width))
        }
    }
}
