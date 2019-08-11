//
//  DRCommon.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import Foundation
import UIKit

// 合并宽度与高度
let DRScreen_Width = UIScreen.main.bounds.size.width
let DRScreen_Height = UIScreen.main.bounds.size.height

//是否流海屏
let iPhoneXSeries = UIApplication.shared.statusBarFrame.size.height == 44.0 ? true : false

//是否iPad
let isiPad = UIDevice.current.userInterfaceIdiom == .pad ? true : false



func isIphoneXSSeries() -> Bool {
    var iPhoneXSeries = false
    if UIDevice.current.userInterfaceIdiom != .phone {
        return iPhoneXSeries
    }
    if #available(iOS 11.0, *) {
        guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
            return false
        }
        if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
            print(unwrapedWindow.safeAreaInsets)
            iPhoneXSeries = true
        }
        
    } else {
        
    }
    
    return iPhoneXSeries
}

