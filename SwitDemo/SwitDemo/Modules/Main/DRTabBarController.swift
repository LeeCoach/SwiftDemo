//
//  DRTabBarController.swift
//  SwitDemo
//
//  Created by liguizhi on 2018/7/24.
//  Copyright © 2018年 Coach. All rights reserved.
//

import UIKit

class DRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //首页
        addChildViewController(childVCName: "DRHomeViewController", title: "首页", imageName: "hmtabbar_icon_home")
        
        //消息
        addChildViewController(childVCName: "DRMessageViewController", title: "消息", imageName: "hmtabbar_icon_discovery")
        
        //工具
        addChildViewController(childVCName: "DRToolViewController", title: "工具", imageName: "hmtabbar_icon_community")
        
        //我的
        addChildViewController(childVCName: "DRMeViewController", title: "我的", imageName: "hmtabbar_icon_mine")
    
        
    }
    
    
    func addChildViewController(childVCName : String , title : String, imageName : String) {
        
        // 获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        
        //根据字符串获取对应的Class
        guard let childVCClass = NSClassFromString(nameSpace + "." + childVCName) else {
            print("没有获取到字符串对应的Class")
            return
        }
        
        //将对应的AnyObject转成控制器的类型
        guard let childVCType = childVCClass as? UIViewController.Type else {
            print("没有获取到对应控制器的类型")
            return
        }
        
        //创建对应的控制器对象
        let childVC = childVCType.init()
        
        //设置子控制器的属性
        childVC.title = title;
        childVC.tabBarItem.image = UIImage(named: "\(imageName)_default")
        childVC.tabBarItem.selectedImage = UIImage(named: "\(imageName)_pressed")
        
        //包装导航控制器
        let childNav = DRNavigationController(rootViewController: childVC)
        
        //添加控制器
        addChild(childNav)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
