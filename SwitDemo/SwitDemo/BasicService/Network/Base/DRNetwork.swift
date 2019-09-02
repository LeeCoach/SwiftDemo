//
//  DRNetwork.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/15.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import HandyJSON

class BaseResult:HandyJSON  {
    var code:Int? = 0
    var msg:String? = nil
    var session:String? = nil
    var data:Any?
    
    var isSuccess: Bool = true
    var isFailure: Bool = false
    
    required init() {
        
    }
}

class error: NSObject {
    
    var msg:String? = nil
    var code:Int? = 0
    
    required override init() {
        
    }
}

/// 声明闭包回调
typealias handlerBlock = (_ responseData: BaseResult) ->(Void)


class DRNetwork: NSObject {
    
    private static let sesstionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    ///公共方法
    static func request(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping handlerBlock) {
        
        var paramsKK = params
        
        if DRUserCenter.shareManager.token == nil {
            DRLog("token 不能为空")
            NotificationCenter.default.post(name: NSNotification.Name(kNotification_getSessionNew), object: nil)
//            return
        }
        paramsKK["s"] = DRUserCenter.shareManager.token
        
        requestPost(urlpath: urlpath, params: paramsKK, completionHandler: completionHandler)
    }
    
    ///获取token
    static func requestToken(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping handlerBlock) {
        
        requestPost(urlpath: urlpath, params: params, completionHandler: completionHandler)
    }
    
    ///通用post方法
    private static func requestPost(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping handlerBlock) {
        
        requestBase(urlpath: urlpath, params: params) { (response) in
            
            if response.result.isSuccess {
                if let jsonString = response.result.value {
                    if let obj = BaseResult.deserialize(from: jsonString as? NSDictionary) {
                        
                        switch(obj.code) {
                        case 200:
                            obj.isSuccess = true
                            obj.isFailure = false
                        case 1001: // token失效，请重新登录
                            NotificationCenter.default.post(name: NSNotification.Name(kNotification_getSessionNew), object: nil)
                            obj.isSuccess = false
                            obj.isFailure = true
                        case 1005: //新设备登录，逼退
                            NotificationCenter.default.post(name: NSNotification.Name(kNotification_logoutOffline), object: nil)
                            obj.isSuccess = false
                            obj.isFailure = true
                        default:
                            DRLog("获取数据异常 errorMsg:\(obj.msg ?? "")")
                            obj.isSuccess = false
                            obj.isFailure = true
                        }
                        completionHandler(obj)
                    }
                }
            } else {
                DRLog(response.error)
                let obj = BaseResult.init()
                obj.msg = "error.description()"
                obj.isSuccess = false
                obj.isFailure = true
                completionHandler(obj)
            }
        }
    }
    
    ///负责最基础的请求
    private static func requestBase(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping (DataResponse<Any>) -> Void) {
        
        ///设置请求头
        let info = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let headers = [
            
            "deviceType": "ios",
            "versionName": info,
        ]
        //"Accept": "application/json",
        ///发起请求，不作业务处理
        sesstionManager.request(urlpath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (responseData) in
                
                DRLog("postUrl：\(String(describing: responseData.request?.url)) \n------->请求结果：\(responseData.result)   \n------->请求时长：\(responseData.timeline) \n------->请求出错：\(String(describing: responseData.error)) \n------->请求到数据： \(responseData.result.value ?? "is NULL") \n*************** end ***************\n\n")
            ///
            completionHandler(responseData)
        }
    }
    
    override init() {
        super.init()
    }

}

class DRNetworkUtil: NSObject  {
    
    
    
    
}
