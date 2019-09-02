//
//  DRNetwork+common.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/28.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

//class DRNetwork_common: DRNetwork {
//
//}

extension DRNetwork {
    
    /// 首页广告位
    ///
    /// - Parameter completionHandler:
    static func getHomeAds(completionHandler:@escaping handlerBlock) {
        
        let url = host_path + "Base/AdsList"

        getCommonPostRequest(urlpath: url, params: Dictionary(), completionHandler: completionHandler)
        
    }
    
    /// 获取全部分类
    ///
    /// - Parameters:
    ///   - type: 1、首页分类，2、获取全部分类，三个层级x数组
    ///   - completionHandler: 回调
    static func getAllCategoryList(type:String,completionHandler:@escaping handlerBlock) {
        let url = host_path + "Base/CategoryList"
        let params:Dictionary<String,String> = [
            "type" : type
        ]
        getCommonPostRequest(urlpath: url, params: params, completionHandler: completionHandler)
    }
    
    /// 获取1-3级单级全部分类
    ///
    /// - Parameters:
    ///   - categoryId: 分类ID，0为一级全部分类，一级分类ID可查询二级相应全部分类，二级分类ID可查询三级相应全部分类
    ///   - completionHandler: 回调
    static func getAllCategoryList(categoryId:String,completionHandler:@escaping handlerBlock) {
        let url = host_path + "Base/CategoryList"
        let params:Dictionary<String,String> = [
            "category_id" : categoryId
        ]
        getCommonPostRequest(urlpath: url, params: params, completionHandler: completionHandler)
    }
    
    
    /// 获取老师列表
    ///
    /// - Parameters:
    ///   - type: 1老师列表 2关注老师 3名师精选
    ///   - keyword: 搜索关键字
    ///   - page: 页码
    ///   - limit: 每页数目
    static func getTeacherList(type:String,keyword:String? = nil,page:Int,limit:Int,completionHandler:@escaping handlerBlock) {
        let url = host_path + "Cis/TeacherList"
        let params:Dictionary<String,Any> = [
            "type" : type,
            "keyword" : keyword ?? "",
            "page" : page,
            "limit" : limit
        ]
        getCommonPostRequest(urlpath: url, params: params, completionHandler: completionHandler)
    }
    
    
    
    private static func getCommonPostRequest(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping handlerBlock) {
        DRNetwork.request(urlpath: urlpath, params: params, completionHandler: completionHandler)
    }
    
}
