//
//  DRColorExtension.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit

class DRColorExtension: UIFont {

}

extension UIColor {
    
    // MARK: 16进制颜色
    class func colorHexStr(_ hex: String, alpha : CGFloat = 1.0) -> UIColor {
        //处理数值
        var cString = hex.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    // MARK: 简化RGB颜色写法
    class func RGBA(_ r:uint,g:uint,b:uint,a:CGFloat = 1.0) ->UIColor {
        let redFloat = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        return UIColor(red: redFloat, green: green, blue: blue, alpha: a)
    }
    
    // MARK: 随机色
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)), alpha: 1.0)
    }
    
    
    
    
}
