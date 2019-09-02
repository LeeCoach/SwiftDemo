//
//  DRFontExtension.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit

class DRFontExtension: UIFont {

}

extension UIFont {
    class func font(_ size:CGFloat = 13) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}

//func font(size:CGFloat) -> UIFont {
//    return UIFont.systemFont(ofSize: size)
//}
