//
//  GlobalConstant+Screen.swift
//  Libs
//
//  Created by yang on 14/03/2018.
//  Copyright © 2017 weibo. All rights reserved.
//

import Foundation
import UIKit

public enum ScreenType {
    case small          //iPhone 4, 4s
    case big            //iPhone 5, 5s
    case bigger         //iPhone 6, 7, 8
    case biggerThanEver //iPhone 6 Plus, 7 Plus, 8 Plus
    case x              //iPhone X
}

public extension C {
    public struct Screen {
        public static var isPortrait: Bool {
            return UIApplication.shared.statusBarOrientation.isPortrait
        }
        
        public static let isiPhoneX: Bool = {
            return type == .x
        }()
        // 屏幕尺寸参考https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
        public static let type: ScreenType = {
            let size = UIScreen.main.bounds.size
            switch min(size.width, size.height) {
            case 320:
                if max(size.height, size.width) > 480 {
                    return .big
                } else {
                    return .small
                }
            case 375:
                if max(size.height, size.width) > 667 {
                    return .x
                } else {
                    return .bigger
                }
            case 414:
                if max(size.height, size.width) > 736 {
                    return .x
                } else {
                    return .biggerThanEver
                }
            default:
                return .bigger
            }
        }()
        
        public static let ratioZoomScale: CGFloat = {
            return min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) / 375
        }()
        
        public static let iPixel: CGFloat = 1/UIScreen.main.scale
    }
}
