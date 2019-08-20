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

class BaseNetworkModel:DRBaseModel  {
    var code:Int = 0
    var msg:String?
}

/// 声明闭包回调
typealias successBlock = (_ responseData: AnyObject?) ->()
typealias faildBlock = (_ error: String?) ->()

class DRNetwork: NSObject {
    
    private static let sesstionManager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    ///公共方法
    static func request(urlpath:String,params:Dictionary<String,Any>,success:@escaping successBlock,faild: @escaping faildBlock) {
        
        var paramsKK = params
        
        if DRUserCenter.shareManager.token == nil {
            DRLog("token 不能为空")
            NotificationCenter.default.post(name: NSNotification.Name(kNotification_getSessionNew), object: nil)
//            return
        }
        paramsKK["s"] = DRUserCenter.shareManager.token
        
        requestPost(urlpath: urlpath, params: paramsKK, success: success, faild: faild)
    }
    
    ///获取token
    static func requestToken(urlpath:String,params:Dictionary<String,Any>,success:@escaping successBlock,faild: @escaping faildBlock) {
        
        requestPost(urlpath: urlpath, params: params, success: success, faild: faild)
    }
    
    ///能用post方法
    private static func requestPost(urlpath:String,params:Dictionary<String,Any>,success:@escaping successBlock,faild: @escaping faildBlock) {
        
        requestBase(urlpath: urlpath, params: params) { (response) in
            
            switch response.result {
            case .success(let json):
                
                let dict = json as! NSDictionary
                let code = dict.object(forKey: "code") as! String
                let errorMsg = dict.object(forKey: "msg") as! String
                DRLog(code)
                switch(code) {
                case "200":
                    success(dict)
                case "1001": // token失效，请重新登录
                    NotificationCenter.default.post(name: NSNotification.Name(kNotification_getSessionNew), object: nil)
                case "1005": //新设备登录，逼退
                    NotificationCenter.default.post(name: NSNotification.Name(kNotification_logoutOffline), object: nil)
                default:
                    DRLog("获取数据异常 errorMsg:\(errorMsg)")
                    faild(errorMsg)
                }
                
            case .failure(let error):
                DRLog("获取数据异常 errorMsg:\(error)")
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
