//
//  DRHomeViewController.swift
//  SwitDemo
//
//  Created by liguizhi on 2018/7/24.
//  Copyright © 2018年 Coach. All rights reserved.
//

import UIKit

class DRHomeViewController: DRViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var dataArray:[String]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initSubView()
    }
    
    func initSubView() {
        
        self.dataArray = [String]()
        for i in 1...20
        {
            self.dataArray.append("第\(i)行")
        }
        
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableView.Style.plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(self.tableView)
        
    }
    //UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID)
        }
        
        cell!.textLabel?.text = self.dataArray![indexPath.row]
        
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
