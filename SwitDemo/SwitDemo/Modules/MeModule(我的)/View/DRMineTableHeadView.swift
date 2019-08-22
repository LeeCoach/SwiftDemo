//
//  DRMineTableHeadView.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/13.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit
import Kingfisher

class DRMineTableHeadView: UIView {
    
    lazy var logoImageView:UIImageView? = {
        let logo = UIImageView.init()
        logo.image = UIImage.init(named: "")
        logo.contentMode = .scaleAspectFit
        logo.backgroundColor = UIColor.init(hexString: "#eeeeee")
        return logo
    }()
    lazy var nameLabel:UILabel? = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.init(hexString: "#000000")
        return label
    }()
    
    var openVipBtn:UIButton? = {
       let btn = UIButton.init(type: .custom)
        btn.setTitle("开通VIP", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "#ffe35e"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.backgroundColor = UIColor.init(hexString: "#F2F2F2")
        btn.addTarget(self, action: #selector(openVipBtnAction(button:)), for: .touchUpInside)
        return btn
    }()
    
    
    var infoModel:DRUserModel! {
        didSet {
            logoImageView?.kf.setImage(with: URL(string: DRUserCenter.shareManager.userModel!.avatarPath!))
            nameLabel?.text = DRUserCenter.shareManager.userModel?.nickname
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView!)
        addSubview(nameLabel!)
        addSubview(openVipBtn!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickBtnAction))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
        
        logoImageView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        })
        
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((logoImageView?.snp.right)!).offset(10)
            make.centerY.equalTo(logoImageView!)
        })
        
        openVipBtn?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview()
            make.centerY.equalTo(logoImageView!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击登录按钮
    @objc func clickBtnAction(button:UIButton) -> () {
        guard DRUserCenter.shareManager.loginStatue == .Online else {
            //需要登录
            DRUserCenter.shareManager.showLoginView(success: { (obj) in
                
                DRHUD.showSuccess(title: "登录成功", subtitle: nil)
                DRInterFaceTool.topViewController()?.navigationController?.popViewController(animated: true)
                
            }) { (errorMsg) in
                DRHUD.showError(title: errorMsg, subtitle: nil)
            }
            return
        }
        
        //进入编辑页面
        
        
    }
    //开通VIP
    @objc func openVipBtnAction(button:UIButton) -> () {
        print("开通VIP")
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
