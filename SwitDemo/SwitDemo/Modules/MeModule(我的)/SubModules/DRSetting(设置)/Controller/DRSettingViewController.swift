//
//  DRSettingViewController.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/21.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

class DRSettingViewController: DRViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var tableView:UITableView = {
        let tab = UITableView.init()
        tab.delegate = self
        tab.dataSource = self
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tab.tableFooterView = UIView.init()
        return tab
    }()
    
    var titleArray:Array<Array<Any>>?

    override func viewDidLoad() {
        super.viewDidLoad()

        if DRUserCenter.shareManager.loginStatue == .Offline {
            titleArray = [["账户安全","清理缓存"],["意见反馈","当前版本"],["登录"]]
        } else {
            titleArray = [["账户安全","清理缓存"],["意见反馈","当前版本"],["退出登录"]]
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr = titleArray![section]
        return arr.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: DRScreen_Width, height: 5))
        footView.backgroundColor = UIColor.init(hexString: "#f2f2f2")
        return footView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") as! UITableViewCell
        let arr = titleArray![indexPath.section]
        cell.textLabel?.text = arr[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2,indexPath.row == 0 {
            
            // 退出登录
            if DRUserCenter.shareManager.loginStatue == .Online {
                
                let alert = UIAlertController.init(title: "提示", message: "确定要退出当前账户?", preferredStyle: .actionSheet)
                
                let action0 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let action1 = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
                    
                    DRUserCenter.shareManager.userLogout(success: { (obj) in
                        DRHUD.showSuccess(title: "退出成功", subtitle: nil)
                        self.navigationController?.popViewController(animated: true)
                    }, faile: { (errorMsg) in
                        DRHUD.showError(title: errorMsg, subtitle: nil)
                    })
                }
                alert.addAction(action0)
                alert.addAction(action1)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                DRUserCenter.shareManager.showLoginView(success: { (obj) in
                    
                    DRHUD.showSuccess(title: "登录成功", subtitle: nil)
                    self.navigationController?.popViewController(animated: true)
                    
                }) { (errorMsg) in
                    DRHUD.showError(title: errorMsg, subtitle: nil)
                }
            }
            
        }
        
    }

}
