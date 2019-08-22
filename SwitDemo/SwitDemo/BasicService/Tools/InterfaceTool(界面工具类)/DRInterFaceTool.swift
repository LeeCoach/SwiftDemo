//
//  DRInterFaceTool.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/19.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit


class DRInterFaceTool: NSObject {
    
    static func topViewController() -> UIViewController? {
        
        if let tabbarVC = tabBarController() {
            
            let navVC = tabbarVC.selectedViewController
            
            if navVC is UINavigationController {
                let navkkVC = navVC as! UINavigationController
                return navkkVC.topViewController
            } else {
                return navVC?.navigationController?.topViewController
            }
            return tabbarVC.navigationController?.topViewController
        }
        return nil
    }
    
    static func tabBarController() -> UITabBarController? {
        
        let windows = UIApplication.shared.windows
        
        for window in windows {
            
            let vc = window.rootViewController
            if vc is UITabBarController {
                return vc as! UITabBarController
            }
        }
        return nil
    }
}
