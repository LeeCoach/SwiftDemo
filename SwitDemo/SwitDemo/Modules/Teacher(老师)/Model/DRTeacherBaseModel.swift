//
//  DRTeacherBaseModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/28.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class DRTeacherBaseModel: HandyJSON {
    /// 老师ID
    var teacher_id:String?
    ///老师照片
    var avaterPath:String?
    ///老师昵称
    var nickname:String?
    ///老师描述
    var abstract:String?
    //讲师称谓
    var teacherAppellation:String?
    ///粉丝人数
    var followNum:String?
    ///关注状态 1已关注 2未关注
    var followStatus:String?

    required init() {
        
    }
}
