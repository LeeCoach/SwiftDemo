//
//  DRUserModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/13.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class DRUserModel: HandyJSON { //DRBaseModel
    /** 用户ID */
    var user_id:String?
    /** 隐藏的手机号码 */
    var account:String?
    /** 完整的手机号码 */
    var mobile:String?
    /** 用户头像 */
    var avatarPath:String?
    /** 用户昵称 */
    var nickname:String?
    /** 真实姓名 */
    var realname:String?
    /** 是否实名认证 */
    var is_verify:Bool = false
    
    /** 性别 1男；2女；3未知； */
    var sex:DRUserSex = .general

    /** 用户类型 1：普通用户 2：老师 3：代理商 4：机构 5:游客 */
    var userType:DRUserType = .visitor
    /** 账号状态 0：禁用 1：启用 */
    var vipStatus:DRVipStatus = .disable
    /** VIP到期时间 */
    var vipEndTime:String?
    /** 总余额 */
    var balance:String?
    /** 不可提现 ,ios充值部分*/
    var noWithdraw:String?
    /** 可提现余额 */
    var totalWithdraw:String?
    /** 总收入 */
    var incprice:String?
    /** 总支出 */
    var exprice:String?
    
    /** 省 */
    var province:String?
    /** 市 */
    var city:String?
    /** 区 */
    var area:String?
    
    ///出生年月日
    var birth_date:String?
    
    /** 老师粉丝 */
    var followNum:String?
    /** 收藏数 */
    var collectionNum:String?
    /** 是否关闭推送 */
    var isClosePush:String?
    /** 老师ID */
    var teacherId:String?
    /** 老师简介 */
    var abstract:String?
    
    
    /** 优惠券数量 */
    var couponNum:String?
    /** 今日收入 */
    var todayInc:String?
    /** 总收入 */
    var totalInc:String?
    /** 剩余发展VIP名额 */
    var development:String?
    /** 直属下级数量 */
    var directDevelop:String?
    /** 间接下级数量 */
    var indirectDevelop:String?
    
    /** 微信昵称 */
    var wxName:String?
    /** 微信号 */
    var wechat:String?
    /** 未读消息数 */
    var messages:String?
    /** 同类型下级人数 老师身份则 下级老师数量 代理商则 */
    var fans_total:String?
    /** 绑定的上级手机号码 */
    var superior:String?
    /** 是否设置了密码 0-否 1-是 */
    var has_password:Int = 0
    
    /** 直播信息 */
    var live:String?
    
    /** 开关  ture-隐  false-显示 */
    var qrc:Bool = false
    
    /** 是否新用户七天免费  YES-免费  NO-不免费 */
    var is_seven_days:Bool = false

    required init() {

    }
}

enum DRUserSex:Int ,HandyJSONEnum {
    case male = 1
    case female = 2
    case general = 3
}

/** 用户类型 1：普通用户 2：老师 3：代理商 4：机构 5:游客 */
enum DRUserType:String ,HandyJSONEnum {
    case member = "1"
    case teacher = "2"
    case agent = "3"
    case organization = "4"
    case visitor = "5"
}

enum DRVipStatus:Int ,HandyJSONEnum {
    case disable = 0
    case enable = 1
}



