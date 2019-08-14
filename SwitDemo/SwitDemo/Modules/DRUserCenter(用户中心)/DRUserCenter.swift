//
//  DRUserCenter.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/14.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON


/// 声明闭包
typealias loginSuccess = (_ object:AnyObject) -> Void
typealias loginFaile = (_ error:Error) -> Void

class DRUserCenter: NSObject {
    
    /// 默认未登录
    var loginStatue:DRLoginState = .not
    
    var userModel:DRUserModel?
    
    var token:String?
    
    var loginSuccessCall:loginSuccess?
    var loginFaileCall:loginFaile?
    
    func userLoginEvent(moblie:String,password:String,smsKey:String,code:String,type:String,success:loginSuccess?,faile:loginFaile?) {
        
        
        loginSuccessCall = success
        
    }
    
    func kdlsklf(){
//        let dict:Dictionary<String, Any>?
//        loginSuccessCall?(dict as AnyObject)
    }

}

/// 登录状态枚举
///
/// - not: 未登录
/// - vistor: 游客
/// - member: 已登录
enum DRLoginState:Int ,HandyJSONEnum {
    case not = 0
    case vistor = 1
    case member = 2
}
