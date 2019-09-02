//
//  DRUserCenter.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/14.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class loginBaseModel: NSObject {
    var data:Any?
    var message:String? = nil
    
    required override init() {
        
    }
}

typealias loginHandler = (_ data:loginBaseModel) -> Void


class DRUserCenter: NSObject {
    
    /// 默认未登录
    var loginStatue:DRLoginState = .Offline
    
    var userModel:DRUserModel?
    
    var token:String?
    
    
    var loginHandlerCall:loginHandler?
    
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
        DRNetwork.requestToken(urlpath: url, params: param) { (BaseResult) -> (Void) in
            
            if BaseResult.isSuccess {
                
                let data = BaseResult.data as? NSDictionary
                if let token = data!["session"] {
                    DRUserCenter.shareManager.token = token as? String
                    DRLog("获取到sesstion: \(DRUserCenter.shareManager.token ?? "为空")")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_getSessionSuccess), object: nil)
                    ///获取用户详情
                    self.userDetails(completionHandler: { (loginBaseModel) in
                        
                    })
                }
            } else {
                
            }
        }
    }
    
    
    
    // MARK: 获取用户详情
    func userDetails(completionHandler:@escaping loginHandler) -> Void {
        
        guard token != nil else {
            DRLog("token不能为空")
            return
        }
        DRLog("开始获取用户详情")
        
        DRNetwork.getUserDetails { (BaseResult) -> (Void) in
            if BaseResult.isSuccess {
                
                let userModel = DRUserModel.deserialize(from: BaseResult.data as? NSDictionary)
                self.userModel = userModel
                let userType:DRUserType = self.userModel!.userType
                
                switch userType {
                case .visitor:
                    self.loginStatue = .Offline
                default:
                    self.loginStatue = .Online
                }
                let model = loginBaseModel.init()
                model.data = userModel
                completionHandler(model)
                
            } else {
                let model = loginBaseModel.init()
                model.message = BaseResult.msg
                completionHandler(model)
            }
        }
    }
    // MARK: 登录
    func userLoginEvent(moblie:String,password:String?,smsKey:String?,code:String?,type:String?,completionHandler:@escaping loginHandler) {
        
        DRNetwork.userLogout { (BaseResult) -> (Void) in
            
            if BaseResult.isSuccess {
                
                let data = BaseResult.data as? NSDictionary
                if let token = data!["session"] {
                    DRUserCenter.shareManager.token = token as? String
                    DRLog("获取到sesstion: \(DRUserCenter.shareManager.token ?? "为空")")
                    
                    ///获取用户详情
                    self.userDetails(completionHandler: { (loginBaseModel) in
                        
                    })
                }
                let model = loginBaseModel.init()
                model.data = self.userModel
                completionHandler(model)
            } else {
                let model = loginBaseModel.init()
                model.message = BaseResult.msg
                completionHandler(model)
            }
        }
    }
    
    // MARK: 退出登录
    func userLogout(completionHandler:@escaping loginHandler) -> Void {
        
        DRNetwork.userLogout { (BaseResult) -> (Void) in
            
            if BaseResult.isSuccess {
                let model = loginBaseModel.init()
                model.data = BaseResult.data
                completionHandler(model)
            } else {
                let model = loginBaseModel.init()
                model.message = BaseResult.msg
                completionHandler(model)
            }
        }
    }
    
    // MARK: 验证用户是否登录，是否游客身份
    func verifyUserLogin(completionHandler:@escaping loginHandler) -> Void {
        
        let userType:DRUserType = self.userModel!.userType
        if userType == .visitor {
            self.showLoginView(completionHandler: completionHandler)
        } else {
            let model = loginBaseModel.init()
            model.data = self.userModel
            completionHandler(model)
        }
        
    }
    
    // MARK: 弹出登录框
    func showLoginView(completionHandler:@escaping loginHandler) -> Void {
        
        self.loginHandlerCall = completionHandler

        
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
    @objc func needReuseLogin(completionHandler:@escaping loginHandler) -> Void {
        
        loginStatue = .Offline
        ///拿到sesstion后，获取用户详情
        self.userDetails(completionHandler: { (loginBaseModel) in
            
        })
        
        DRInterFaceTool.topViewController()?.navigationController?.popToRootViewController(animated: false)
        
        self.showLoginView { (loginBaseModel) in
            
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
