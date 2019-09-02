//
//  DRCommon.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import Foundation
import UIKit


func DRLog<T>(_ message:T,file:String = #file,function:String = #function,line:Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
    print("**************** \(fileName) ********************** \n----->>>>>>函数名 : \(function) \n----->>>>>>行号 : \(line) \n----->>>>>>输出 : \(message)\n")
    #endif
}

let DRScale_course  = 0.5625

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

