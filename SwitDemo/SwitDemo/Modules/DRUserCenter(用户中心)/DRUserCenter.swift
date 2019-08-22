//
//  DRUserCenter.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/14.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON


class DRUserCenter: NSObject {
    
    /// 默认未登录
    var loginStatue:DRLoginState = .Offline
    
    var userModel:DRUserModel?
    
    var token:String?
    
    
    var loginSuccessCall:successBlock?
    var loginFaileCall:faildBlock?
    
    // MARK:  单例方法
    static let shareManager: DRUserCenter = {
        let instance = DRUserCenter()
        //do something
        
        NotificationCenter.default.addObserver(self, selector: #selector(getUserSession), name: NSNotification.Name(kNotification_getSessionNew), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(needReuseLogin), name: NSNotification.Name(kNotification_logoutOffline), object: nil)
        
        return instance
    } ()
    
    // MARK: 获取session
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
//                self.userDetails(success: {
//
//                }, faile: { (msg) in
//
//                })
                self.userDetails(success: { (obj) in
                    
                }, faile: { (errorMsg) in
                    
                })
            }
        }) { (error) in
            DRLog(error)
        }
    }
    
    
    
    // MARK: 获取用户详情
    func userDetails(success:@escaping successBlock,faile:@escaping faildBlock) -> Void {
        
        guard token != nil else {
            DRLog("token不能为空")
            return
        }
        DRLog("开始获取用户详情")
        DRNetwork.getUserDetails({ (objData) in
            let userModel = objData as? DRUserModel
            self.userModel = userModel
            let userType:DRUserType = self.userModel!.userType
            
            switch userType {
            case .visitor:
                self.loginStatue = .Offline
            default:
                self.loginStatue = .Online
            }
            success(objData)
        
        }) { (errorMsg) in
            DRLog(errorMsg!)
            faile(errorMsg)
        }
    }
    // MARK: 登录
    func userLoginEvent(moblie:String,password:String?,smsKey:String?,code:String?,type:String?,success:@escaping successBlock,faile:@escaping faildBlock) {
        
        DRNetwork.userLogin(moblie: moblie, password: password, smsKey: smsKey, code: code, type: type, { (obj) in

            let dict = obj as! NSDictionary
            let data = dict["data"] as! NSDictionary
            if let token = data["session"] {
                DRUserCenter.shareManager.token = token as? String
                DRLog("登录成功 获取到sesstion: \(DRUserCenter.shareManager.token ?? "为空")")

                ///拿到sesstion后，获取用户详情
                self.userDetails(success: { (data) in
                    
                }, faile: { (errorMsg) in
                    
                })
                
                success(obj)
            }

        }) { (errorMsg) in
            faile(errorMsg!)
        }
    }
    
    // MARK: 退出登录
    func userLogout(success:@escaping successBlock, faile:@escaping faildBlock) -> Void {
        
        DRNetwork.userLogout({ (obj) in
            success(obj)
            self.loginStatue = .Offline
        }) { (errorMsg) in
            faile(errorMsg)
        }
    }
    
    // MARK: 验证用户是否登录，是否游客身份
    func verifyUserLogin(success:@escaping successBlock,faile:@escaping faildBlock) -> Void {
        
        let userType:DRUserType = self.userModel!.userType
        if userType == .visitor {
            self.showLoginView(success: success, faile: faile)
        } else {
            success(self.userModel)
        }
        
    }
    
    // MARK: 弹出登录框
    func showLoginView(success:@escaping successBlock,faile:@escaping faildBlock) -> Void {
        
        self.loginSuccessCall = success
        self.loginFaileCall = faile
        
        let currentVC = DRInterFaceTool.topViewController()
        if (currentVC?.isKind(of: DRLoginViewController.self))! {
            return
        }
        
        let loginVC = DRLoginViewController.init()
        let navVC = UINavigationController(rootViewController: loginVC)
        DRInterFaceTool.topViewController()?.present(navVC, animated: true, completion: {
            
        })
        
    }
    
    
    
    // MARK: 通知重新登录
    @objc func needReuseLogin(success:@escaping successBlock, faile:@escaping faildBlock) -> Void {
        
        loginStatue = .Offline
        ///拿到sesstion后，获取用户详情
        self.userDetails(success: { (data) in
            
        }, faile: { (errorMsg) in
            
        })
        
        DRInterFaceTool.topViewController()?.navigationController?.popToRootViewController(animated: false)
        
        self.showLoginView(success: { (obj) in
            
        }) { (errorMsg) in
            
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

/// 登录状态枚举
///
/// - not: 未登录
/// - vistor: 游客
/// - member: 已登录
enum DRLoginState:Int ,HandyJSONEnum {
    case Offline = 1
    case Online = 2
}
