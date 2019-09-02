//
//  DRCourseBaseModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/27.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON

enum DRCourseType:Int,HandyJSONEnum {
    case courseTypeFree = 1
    case courseTypePay = 2
    case courseTypeLive = 3
    case courseTypeVIP = 4
}

class DRCourseBaseModel: HandyJSON {
    /** 课程ID */
    var courseId:String?
    /** 课程名称 */
    var name:String?
    /** 课程横图 */
    var wimagePath:String?
    /** 课程竖图 */
    var himagePath:String?
    /** 购买数量 */
    var buyNum:String?
    /** 浏览量 */
    var browseNumber:String?
    /** 是否购买 */
    var isBuy:String?
    /** 课程价格 */
    var price:String?
    /** 课程简介 */
    var abstract:String?
    /** 课程类型1 免费课程 2 付费专栏3 互动直播 4VIP 课程 */
    var courseType:DRCourseType? = .courseTypeFree
    
    /** 直播状态 1：直播中 2：未直播 */
    var isLive:Int?
    /** 直播开始时间 */
    var liveTime:String?
    /** 直播开始时间的短时间 H:i 时:分 */
    var liveShortTime:String?
    /** 直播观看人数 */
    var livePeopleNum:String?
    
    /** 课程是否结束 1 已结束 2 未结束 */
    var isOver:String?
    /** 所在分类名称 */
    var className:String?
    /** 是否评价 1是 2否 */
    var isComment:String?
    
    required init() {
        
    }
    
    
}
