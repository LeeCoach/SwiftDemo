//
//  DRHomeViewController.swift
//  SwitDemo
//
//  Created by liguizhi on 2018/7/24.
//  Copyright © 2018年 Coach. All rights reserved.
//

import UIKit
import ESPullToRefresh

class DRHomeViewController: DRViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var dataArray:Array<DRSectionConfingModel> = Array.init()
    var bannerModolArr:Array<DRAdsModel> = Array.init()
    var categoryModelArr:Array<DRCategoryBaseModel> = Array.init()
    
    fileprivate let kLikeCourse = "免费专区"
    fileprivate let kQualityCourse = "精品课程"
    fileprivate let kFamousTeacher = "名师专题"
    fileprivate let kHobbyCourse = "兴趣爱好"
    fileprivate let kVIPRecommendedCourse = "VIP精品推荐"
    fileprivate let kPaidCourse = "付费专栏"
    fileprivate let kHomeAd = "首页广告"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initSubView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(requestGroup), name: NSNotification.Name(kNotification_getSessionSuccess), object: nil)
    }
    
    func initSubView() {
        
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.tableView.es.addPullToRefresh {
            self.requestReloadData()
            self.requestTableHeaderData()
        }
        
    }
    
    @objc fileprivate func requestGroup() {
        
        if DRUserCenter.shareManager.token == nil {
            return
        }
        
        self.requestReloadData()
        self.requestTableHeaderData()
    }
    
    private func requestReloadData() {
        
        let section0 =  DRSectionConfingModel.init()
        section0.sectionHeadTitle = kLikeCourse
        section0.sortNum = NSNumber.init(value: 0)
        
        let section1 =  DRSectionConfingModel.init()
        section1.sectionHeadTitle = kQualityCourse
        section1.sortNum = NSNumber.init(value: 1)
        
        let section2 =  DRSectionConfingModel.init()
        section2.sectionHeadTitle = kFamousTeacher
        section2.sortNum = NSNumber.init(value: 2)
        
        let section3 =  DRSectionConfingModel.init()
        section3.sectionHeadTitle = kVIPRecommendedCourse
        section3.sortNum = NSNumber.init(value: 3)
        
        let section4 =  DRSectionConfingModel.init()
        section4.sectionHeadTitle = kHomeAd
        section4.sortNum = NSNumber.init(value: 4)
        
        let section5 =  DRSectionConfingModel.init()
        section5.sectionHeadTitle = kPaidCourse
        section5.sortNum = NSNumber.init(value: 5)
        
        DRHUD.showLoading(title: "加载中……")
        let group = DispatchGroup.init()
        let myQueue = DispatchQueue(label: "com.homeQueue", qos: .utility)
        
        group.enter()
        myQueue.async(group: group, qos: .default, flags: []) {
            //*************  猜你喜欢   ***************//
            DRNetwork.getCourseList(act: "1", type: "3", page: 1, limit: 6) { (BaseResult) -> (Void) in
                if BaseResult.isSuccess {
                    let model:DRHomeModel = DRHomeModel.deserialize(from: BaseResult.data as? NSDictionary)!
                    section0.sectionItems = model.course
                    self.dataArray.append(section0)
                    
                } else {
                    DRLog(BaseResult.msg)
                }
                group.leave()
            }
        }
//        myQueue.async {
//
//        }
        
        group.enter()
        myQueue.async(group: group, qos: .default, flags: []) {
            //*************  精品课程   ***************//
            DRNetwork.getCourseList(act: "9", type: "3", page: 1, limit: 3) { (BaseResult) -> (Void) in
                if BaseResult.isSuccess {
                    
                    let model = DRHomeModel.deserialize(from: BaseResult.data as? NSDictionary)
                    section1.sectionItems = model?.course
                    self.dataArray.append(section1)
                    
                } else {
                    DRLog(BaseResult.msg)
                }
                group.leave()
            }
        }
//        myQueue.async {
//
//        }
        
        group.enter()
        myQueue.async(group: group, qos: .default, flags: []) {
            //*************  名师专题   ***************//
            DRNetwork.getTeacherList(type: "1", page: 1, limit: 4, completionHandler: { (BaseResult) -> (Void) in
                
                if BaseResult.isSuccess {
                    
                    DRLog(BaseResult.data)
                    let array = Array<DRTeacherBaseModel>.deserialize(from: BaseResult.data as? Array)
                    section2.sectionItems = array as Array<AnyObject>?
                    self.dataArray.append(section2)
                } else {
                    DRLog(BaseResult.msg)
                }
                group.leave()
            })
        }
//        myQueue.async {
//
//        }
    
        
        group.notify(queue: myQueue) {
            
            DRLog(self.dataArray)
//            self.dataArray?.sort(by: { (model1, model2) -> Bool in
//                return model1.sortNum?.compare(model2.sortNum!)
//            })
            DispatchQueue.main.async {
                self.tableView.es.stopPullToRefresh()
                self.tableView.reloadData()
            }
            DRHUD.hide()
//            DRLog("刷新列表 \(self.dataArray)")
        }
        
    }
    
    private func requestTableHeaderData(){
        DRNetwork.getHomeAds { (BaseResult) -> (Void) in
//            DRLog(BaseResult.data)
            
            let adlArr = Array<DRAdsModel>.deserialize(from: BaseResult.data as? Array)
//            self.bannerModolArr = adlArr! as! Array<DRAdsModel>
            self.bannerModolArr += adlArr! as! Array<DRAdsModel>
        }
        
        DRNetwork.getAllCategoryList(type: "1") { (BaseResult) -> (Void) in
//            DRLog(BaseResult.data)
            let categoryArr = Array<DRCategoryBaseModel>.deserialize(from: BaseResult.data as? Array)
//            self.categoryModelArr = categoryArr! as! Array<DRCategoryBaseModel>
            self.categoryModelArr += categoryArr! as! Array<DRCategoryBaseModel>
        }
        
        self.setupTableHeaderView()
    }
    
    fileprivate func setupTableHeaderView() {
        let headerView = DRHomeHeaderView(frame: CGRect(x: 0, y: 0, width: DRScreen_Width, height: DRScreen_Width*0.42 + 100))
        headerView.adsArr = self.bannerModolArr
        headerView.categoryArr = self.categoryModelArr
        self.tableView.tableHeaderView = headerView
        self.tableView.reloadData()
    }
    
    
    //UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        DRLog(self.dataArray)
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        }
        
        cell!.textLabel?.text = "24352"//self.dataArray![indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: "提示", message: "测试", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let OkAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("click the ok!")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: nil)
        
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
