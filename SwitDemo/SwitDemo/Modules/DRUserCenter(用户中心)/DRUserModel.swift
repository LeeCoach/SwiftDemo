//
//  DRUserModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/13.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class DRUserModel: NSObject {
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
//     var sex:userSex
    
    /*
    /** 用户类型 1：普通用户 2：老师 3：代理商 4：机构 5:游客 */
    @property (nonatomic, assign) WLUserType userType;
    /** 账号状态 0：禁用 1：启用 */
    @property (nonatomic, assign) WLVipStatus vipStatus;
    /** VIP到期时间 */
    @property (nonatomic, strong) NSString *vipEndTime;
    /** 总余额 */
    @property (nonatomic, strong) NSString *balance;
    /** 不可提现 ,ios充值部分*/
    @property (nonatomic, strong) NSString *noWithdraw;
    /** 可提现余额 */
    @property (nonatomic, strong) NSString *totalWithdraw;
    /** 总收入 */
    @property (nonatomic, strong) NSString *incprice;
    /** 总支出 */
    @property (nonatomic, strong) NSString *exprice;
    
    /** 省 */
    @property (nonatomic, strong) NSString *province;
    /** 市 */
    @property (nonatomic, strong) NSString *city;
    /** 区 */
    @property (nonatomic, strong) NSString *area;
    
    ///出生年月日
    @property (nonatomic, copy) NSString *birth_date;
    
    /** 老师粉丝 */
    @property (nonatomic, strong) NSString *followNum;
    /** 收藏数 */
    @property (nonatomic, strong) NSString *collectionNum;
    /** 是否关闭推送 */
    @property (nonatomic, strong) NSString *isClosePush;
    /** 老师ID */
    @property (nonatomic, strong) NSString *teacherId;
    /** 老师简介 */
    @property (nonatomic, strong) NSString *abstract;
    
    
    /** 优惠券数量 */
    @property (nonatomic, strong) NSString *couponNum;
    /** 今日收入 */
    @property (nonatomic, strong) NSString *todayInc;
    /** 总收入 */
    @property (nonatomic, strong) NSString *totalInc;
    /** 剩余发展VIP名额 */
    @property (nonatomic, strong) NSString *development;
    /** 直属下级数量 */
    @property (nonatomic, strong) NSString *directDevelop;
    /** 间接下级数量 */
    @property (nonatomic, strong) NSString *indirectDevelop;
    
    /** 微信昵称 */
    @property (nonatomic, strong) NSString *wxName;
    /** 微信号 */
    @property (nonatomic, strong) NSString *wechat;
    /** 未读消息数 */
    @property (nonatomic, strong) NSString *messages;
    /** 同类型下级人数 老师身份则 下级老师数量 代理商则 */
    @property (nonatomic, strong) NSString *fans_total;
    /** 绑定的上级手机号码 */
    @property (nonatomic, strong) NSString *superior;
    /** 是否设置了密码 0-否 1-是 */
    @property (nonatomic, assign) NSInteger has_password;
    
    /** 直播信息 */
    @property (nonatomic, strong) NSString *live;
    
    /** 开关  ture-隐  false-显示 */
    @property (nonatomic, assign) BOOL qrc;
    
    /** 是否新用户七天免费  YES-免费  NO-不免费 */
    @property (nonatomic, assign) BOOL is_seven_days;
*/
}

//enum userSex:Int ,HandyJSONEnum {
//    case male = 1
//    case female = 2
//    case general = 3
//}

class testModel: DRBaseModel {
    var name:String?
    var height:Int = 0
}
