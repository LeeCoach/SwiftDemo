//
//  DRMeViewController.swift
//  SwitDemo
//
//  Created by liguizhi on 2018/7/24.
//  Copyright © 2018年 Coach. All rights reserved.
//

import UIKit

class DRMeViewController: DRViewController,UITableViewDelegate,UITableViewDataSource {
    
    let kMyCollection = "我的收藏"
    let kMyAttention = "我的关注"
    let kHistoryTrack = "历史足迹"
    let kDiscountCoupon = "我的优惠券"
    let kMyDownload = "我的课件"
    let kRechargeCard = "共享充值卡"
    let kAcademicAnalysis = "学情分析"
    let kInspectorManagement = "督学管理"
    let kLearningCircle = "共学圈"
    
    let kApplyTeacher = "申请老师"
    let kApplyAgency = "申请代理"
    
    let kService = "联系客服"
    let kHelpCenter = "帮助中心"
    let kMyMessage = "我的消息"
    let kAppGrade = "APP评分"
    
    let kSettingUp = "设置"
    let kEvaluation = "测评"
    
    var tableView:UITableView!
    var dataArray:[AnyObject]!
    
    var headView:DRMineTableHeadView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGroup()
        
        self.tableView = UITableView.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        headView = DRMineTableHeadView.init(frame: CGRect(x: 0, y: 0, width: DRScreen_Width, height: 100)) as DRMineTableHeadView
        headView?.infoModel = DRUserCenter.shareManager.userModel
        tableView.tableHeaderView = headView
        
        self.tableView.register(DRMineTableViewCell.self, forCellReuseIdentifier: "DRMineTableViewCell")
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
    }
    
    func setGroup() {
        let collectionItem = DRCellConfingModel.init(imageName: "mine_icon_collection", title: kMyCollection)
        
        let attentionitem = DRCellConfingModel.init(imageName: "mine_icon_attention", title: kMyAttention)
        
        let historyTrackitem = DRCellConfingModel.init(imageName: "mine_icon_history", title: kHistoryTrack)
        
        let couponitem = DRCellConfingModel.init(imageName: "mine_icon_coupon", title: kDiscountCoupon)
        
        let myDownloaditem = DRCellConfingModel.init(imageName: "mine_icon_download", title: kMyDownload)
        
        let teacherItem = DRCellConfingModel.init(imageName: "mine_icon_applyTeacher", title: kApplyTeacher)
        
        let agencyItem = DRCellConfingModel.init(imageName: "mine_icon_agency", title: kApplyAgency)
        
        let serviceItem = DRCellConfingModel.init(imageName: "mine_icon_tel", title: kService)
        
        let helpItem = DRCellConfingModel.init(imageName: "mine_icon_help", title: kHelpCenter)
        
        let messageitem = DRCellConfingModel.init(imageName: "mine_icon_message", title: kMyMessage)
        
        let appGradeitem = DRCellConfingModel.init(imageName: "mine_icon_appGrade", title: kAppGrade, detali:"评分支持一下吧")
        
        let settingItem = DRCellConfingModel.init(imageName: "mine_icon_settings", title: kSettingUp)
  
        
        let section0 = DRSectionConfingModel.init()
        section0.sectionHeadHeight = 5
        section0.sectionItems = [collectionItem,attentionitem,historyTrackitem,couponitem,myDownloaditem]
        
        let section1 = DRSectionConfingModel.init()
        section1.sectionHeadHeight = 5
        section1.sectionItems = [teacherItem,agencyItem]
        
        let section2 = DRSectionConfingModel.init()
        section2.sectionHeadHeight = 5
        section2.sectionItems = [serviceItem,helpItem,messageitem,appGradeitem]
        
        let section3 = DRSectionConfingModel.init()
        section3.sectionHeadHeight = 5
        section3.sectionItems = [settingItem]

        self.dataArray = [section0,section1,section2,section3]
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group:DRSectionConfingModel = self.dataArray[section] as! DRSectionConfingModel
        return (group.sectionItems?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DRMineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DRMineTableViewCell", for: indexPath) as! DRMineTableViewCell
        let group:DRSectionConfingModel = self.dataArray[indexPath.section] as! DRSectionConfingModel
        cell.cellModel = group.sectionItems![indexPath.row] as? DRCellConfingModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let group:DRSectionConfingModel = self.dataArray[section] as! DRSectionConfingModel
        return group.sectionHeadHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headVeiw = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UITableViewHeaderFooterView")
        headVeiw!.contentView.backgroundColor = UIColor.init(hexString: "#f2f2f2")
        
        return headVeiw
    }

}
