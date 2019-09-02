//
//  DRNetwork+Course.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/27.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

//class DRNetwork_Course: DRNetwork {
//
//}

extension DRNetwork {
    
    static func getCourseList(act:String,type:String,page:Int,limit:Int,firstClass:String? = "",secondClass:String? = "",thirdClass:String? = "",grade:String? = "",isBuy:String? = "",teacherId:String? = "",keywords:String? = "",sort:String? = "",completionHandler:@escaping handlerBlock) {
        
        let url = host_path + "Course/CourseList"
        let params:Dictionary<String,Any> = [
            "act" : act,
            "type" : type,
            "page" : page,
            "limit" : limit,
            "firstClass" : firstClass,
            "secondClass" : secondClass,
            "thirdClass" : thirdClass,
            "grade" : grade,
            "isBuy" : isBuy,
            "teacherId" : teacherId,
            "keywords" : keywords,
            "sort" : sort
        ]
        getCoursePostRequest(urlpath: url, params: params, completionHandler: completionHandler)
        
    }
    
    private static func getCoursePostRequest(urlpath:String,params:Dictionary<String,Any>,completionHandler:@escaping handlerBlock) {
        DRNetwork.request(urlpath: urlpath, params: params, completionHandler: completionHandler)
    }
}
