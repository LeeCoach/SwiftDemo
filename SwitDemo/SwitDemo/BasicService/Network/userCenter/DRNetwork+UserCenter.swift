//
//  DRNetwork+UserCenter.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/16.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

//class DRNetwork_UserCenter: DRNetwork {
//
//}


extension DRNetwork {
    
    // MARK: 获取用户详情
    static func getUserDetails(_ success:@escaping successBlock ,_ faild:@escaping faildBlock) {
        
        let url = host_path + "Cis/UserDetails"
//        let params:Dictionary<String,String> = ["s" : DRUserCenter.shareManager.token!]
        DRNetwork.request(urlpath: url, params: Dictionary(), success: { (response) in
            
            let userModel:DRUserModel = DRUserModel.dictionaryToModel(response as! [String : Any], DRUserModel.self) as! DRUserModel
            success(userModel)
            
        }) { (errorMsg) in
            faild(errorMsg!)
        }
    }
    
    
    // MARK: 登录
    static func userLogin(moblie:String,password:String?,smsKey:String?,code:String?,type:String?,_ success:@escaping successBlock ,_ faild:@escaping faildBlock) {
        
        let url = host_path + "Cis/UserLogin"
        let params:Dictionary<String,String> = [
            "mobile" : moblie,
            "password" : password!,
            "smsKey" : smsKey!,
            "code" : code!,
            "type" : type!
        ]
        DRNetwork.request(urlpath: url, params: params, success: { (obj) in
            
            success(obj)
            
        }) { (errorMsg) in
            faild(errorMsg!)
        }
    }
    
    // MARK: 退出登录
    static func userLogout(_ success:@escaping successBlock ,_ faild:@escaping faildBlock) {
        let url = host_path + "Cis/UserLogout"
        let params:Dictionary<String,String> = ["s" : DRUserCenter.shareManager.token!]
        DRNetwork.request(urlpath: url, params: params, success: { (response) in
            
            let userModel:DRUserModel = DRUserModel.dictionaryToModel(response as! [String : Any], DRUserModel.self) as! DRUserModel
            success(userModel)
            
        }) { (errorMsg) in
            faild(errorMsg!)
        }
    }
    
}
