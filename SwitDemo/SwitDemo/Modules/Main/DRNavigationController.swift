//
//  DRNavigationController.swift
//  SwitDemo
//
//  Created by liguizhi on 2018/7/24.
//  Copyright © 2018年 Liguizhi. All rights reserved.
//

import UIKit

class DRNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.view.backgroundColor = UIColor.white;
        
//        self.extendedLayoutIncludesOpaqueBars = false //设置Y起始位置为导航栏下，当设置为YES时，视图在导航栏层下，状态栏下位置开始
//        self.automaticallyAdjustsScrollViewInsets = false
        
//        let navigationBar = UINavigationBar.appearance()
//        navigationBar.setBackgroundImage(UIImage.init(), for: .default) //导航背景色
//        navigationBar.shadowImage = UIImage.init()  //导航底线

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigation_btn_forward_black"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }

    @objc private func navigationBack() {
        popViewController(animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
