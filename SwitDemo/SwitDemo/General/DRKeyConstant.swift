//
//  DRKeyConstant.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/19.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

#if DEBUG
let host_path = "https://sandbox.litakeji.com/apiV2/"
let host_path_v1 = "https://sandbox.litakeji.com/apiV2/"
#else
let host_path = "https://gxsz.litakeji.com/apiV2/"
let host_path_v1 = "https://gxsz.litakeji.com/api/"


#endif
//获取新的seesion
let kNotification_getSessionNew = "kNotification_getSessionNew"
//seesion获取成功
let kNotification_getSessionSuccess = "kNotification_getSessionSuccess"
//登录成功
let kNotification_loginOnline = "kNotification_loginOnline"
//逼退下线
let kNotification_logoutOffline = "kNotification_logoutOffline"
//成功退出
let kNotification_logoutSuccess = "kNotification_logoutSuccess"

//网络状态
let kNotification_networkStatus = "kNotification_networkStatus"

class DRKeyConstant: NSObject {

}
