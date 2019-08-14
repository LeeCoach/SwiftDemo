//
//  DRJsonUtil.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/13.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class DRJsonUtil: DRBaseModel {
    
    /**
     *  Json转对象
     */
    static func jsonToModel(_ jsonStr:String,_ modelType:HandyJSON.Type) -> DRBaseModel {
        
        if jsonStr == "" || jsonStr.count == 0 {
            #if DEBUG
                print("jsonModel 字符串为空")
            #endif
            return DRBaseModel()
        }
        return modelType.deserialize(from: jsonStr) as! DRBaseModel
    }
    
    /**
     *  Json转数组对象
     */
    static func jsonArrayToModel(_ jsonArrayStr:String, _ modelType:HandyJSON.Type) ->[DRBaseModel] {
        if jsonArrayStr == "" || jsonArrayStr.count == 0 {
            #if DEBUG
            print("jsonToModelArray:字符串为空")
            #endif
            return []
        }
        var modelArray:[DRBaseModel] = []
        let data = jsonArrayStr.data(using: String.Encoding.utf8)
        let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
        for people in peoplesArray! {
            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        }
        return modelArray
        
    }
    
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any],_ modelType:HandyJSON.Type) -> DRBaseModel {
        if dictionStr.count == 0 {
            #if DEBUG
            print("dictionaryToModel:字符串为空")
            #endif
            return DRBaseModel()
        }
        return modelType.deserialize(from: dictionStr) as! DRBaseModel
    }
    
    /**
     *  对象转JSON
     */
    static func modelToJson(_ model:DRBaseModel?) -> String {
        if model == nil {
            #if DEBUG
            print("modelToJson:model为空")
            #endif
            return ""
        }
        return (model?.toJSONString())!
    }
    
    /**
     *  对象转字典
     */
    static func modelToDictionary(_ model:DRBaseModel?) -> [String:Any] {
        if model == nil {
            #if DEBUG
            print("modelToJson:model为空")
            #endif
            return [:]
        }
        return (model?.toJSON())!
    }

}
