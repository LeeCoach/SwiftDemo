//
//  DRSectionConfingModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/12.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit

class DRSectionConfingModel: NSObject {
    var sectionHeadTitle: String?
    var sectionFootTitle: String?
    var sectionHeadHeight: CGFloat = 0.00
    var sectionFootHeight: CGFloat = 0.00
    var sectionItems:Array<AnyObject>?
    var sortNum:NSNumber?
}
