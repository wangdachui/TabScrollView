//
//  GlobalConstant+Distance.swift
//  Libs
//
//  Created by yang on 14/03/2018.
//  Copyright © 2017 weibo. All rights reserved.
//

import Foundation
import UIKit

public extension C {
    public struct Distance {
        /// 在iPhone X下的安全区域（不包括NavigationBar的高度）
        public static var safeAreaEdgeInsets: UIEdgeInsets {
            guard C.Screen.type == .x else {
                return .zero
            }
            if C.Screen.isPortrait {
                return UIEdgeInsets(top: 24, left: 0, bottom: 34, right: 0)
            } else {
                return UIEdgeInsets(top: 0, left: 44, bottom: 21, right: 44)
            }
        }
        
        /// 状态栏高度
        public static let statusBarHeight: CGFloat = C.Screen.isPortrait ? 20 : 0
        
        /// 状态栏高度（包含Safe Area）
        public static var statusBarHeightWithSafeArea: CGFloat {
            return statusBarHeight + safeAreaEdgeInsets.top
        }
        
        /// 导航条高度
        public static let navBarHeight: CGFloat = C.Screen.isPortrait ? 44 : 32
        
        /// 导航条高度（包含Safe Area）
        public static var navBarHeightWithSafeArea: CGFloat {
            return navBarHeight + statusBarHeight + safeAreaEdgeInsets.top
        }
        
        /// Tab条高度
        public static let tabBarHeight: CGFloat = C.Screen.isPortrait ? 49 : 32
        
        /// Tab条高度（包含Safe Area）
        public static var tabBarHeightWithSafeArea: CGFloat {
            return tabBarHeight + safeAreaEdgeInsets.bottom
        }
    }
}
