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
typealias loginSuccess = () -> ()
typealias loginFaile = (_ errorMsg:String) -> ()

class DRUserCenter: NSObject {
    
    /// 默认未登录
    var loginStatue:DRLoginState = .not
    
    var userModel:DRUserModel?
    
    var token:String?
    
    var loginSuccessCall:loginSuccess?
    var loginFaileCall:loginFaile?
    
    /// 单例方法
    static let shareManager: DRUserCenter = {
        let instance = DRUserCenter()
        //do something
        
        NotificationCenter.default.addObserver(self, selector: #selector(getUserSession), name: NSNotification.Name(kNotification_getSessionNew), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(needReuseLogin), name: NSNotification.Name(kNotification_logoutOffline), object: nil)
        
        return instance
    } ()
    
    ///获取session
    @objc func getUserSession() -> Void {
        
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let deviceType = "1"
        let model = UIDevice.current.model
        let info = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        
        let param:Dictionary<String,String> = [
            "deviceToken" : uuid!,
            "deviceType" : deviceType,
            "model" : model,
            "version" : info as! String
        ]
        
        let url = host_path + "Base/Session"
        DRNetwork.requestToken(urlpath: url, params: param, success: { (response) in
            
            let dict = response as! NSDictionary
            let data = dict["data"] as! NSDictionary
            if let token = data["session"] {
                DRUserCenter.shareManager.token = token as? String
                DRLog("获取到sesstion: \(DRUserCenter.shareManager.token ?? "为空")")
                
                ///拿到sesstion后，获取用户详情
                self.userDetails(success: {
                    
                }, faile: { (msg) in
                    
                })
            }
        }) { (error) in
            
        }
        
    }
    
    ///获取用户详情
    func userDetails(success:loginSuccess?,faile:loginFaile?) -> Void {
        
        guard token != nil else {
            DRLog("token不能为空")
            return
        }
        DRLog("开始获取用户详情")
        DRNetwork.getUserDetails({ (objData) in
            let userModel = objData as? DRUserModel
            self.userModel = userModel
            let userType = self.userModel?.userType
//            switch  userType {
//            case :
//                loginStatue = .member
//
//            default:
//                loginStatue = .vistor
//            }
            
        }) { (errorMsg) in
            print(errorMsg!)
        }
    }
    //登录
    func userLoginEvent(moblie:String,password:String?,smsKey:String?,code:String?,type:String?,success:@escaping loginSuccess,faile:@escaping loginFaile) {
        
        DRNetwork.userLogin(moblie: moblie, password: password, smsKey: smsKey, code: code, type: type, { (obj) in

            let dict = obj as! NSDictionary
            let data = dict["data"] as! NSDictionary
            if let token = data["session"] {
                DRUserCenter.shareManager.token = token as? String
                DRLog("登录成功 获取到sesstion: \(DRUserCenter.shareManager.token ?? "为空")")

                ///拿到sesstion后，获取用户详情
                self.userDetails(success: {
                    
                }, faile: { (msg) in
                    
                })
                
                success()
            }

        }) { (errorMsg) in
            faile(errorMsg!)
        }
    }
    
    ///退出登录
    func userLogout(_ success: @escaping ()->(), faile: @escaping (_ errorMsg:String?)->()) -> Void {
        
        
        
        
    }
    
    /// 验证用户是否登录，是否游客身份
    ///
    /// - Parameters:
    ///   - success: 成功回调
    ///   - faile: 失败回调
    func verifyUserLogin(_ success: @escaping ()->(), faile: @escaping (_ errorMsg:String?)->()) -> Void {
    
        
    }
    
    // MARK: 弹出登录框
    func showLoginView(success:loginSuccess?,faile:loginFaile?) -> Void {
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: 通知重新登录
    @objc func needReuseLogin(_ success: @escaping ()->(), faile: @escaping (_ errorMsg:String?)->()) -> Void {
        
        loginStatue = .vistor
        ///拿到sesstion后，获取用户详情
        self.userDetails(success: {
            
        }, faile: { (msg) in
            
        })
        
        self.showLoginView(success: {
            
        }) { (errormsg) in
            
        }
        
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
