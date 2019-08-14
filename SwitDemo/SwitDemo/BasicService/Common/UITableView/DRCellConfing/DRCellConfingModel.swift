//
//  DRCellConfingModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit

class DRCellConfingModel: NSObject {
    
    var indexPath:IndexPath?
    var cellClassName:String?
    var imageName:String?
    var titleString:String?
    var placeholderStr:String?
    var detailString:String?
    var detailColor:UIColor?
    var detailFont:UIFont?
    
    var isHiddenBottomLine:Bool = false
    var showNextIcon: Bool = false
    var isSelect: Bool = false
    
    //构造函数
    init(title:String,detali:String) {
        self.titleString = title
        self.detailString = detali
    }
    
    init(imageName:String,title:String) {
        self.imageName = imageName
        self.titleString = title
    }
    
    init(imageName:String,title:String,detali:String) {
        self.imageName = imageName
        self.titleString = title
        self.detailString = detali
    }


}
