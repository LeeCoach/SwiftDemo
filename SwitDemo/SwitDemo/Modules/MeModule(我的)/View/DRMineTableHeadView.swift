//
//  DRMineTableHeadView.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/13.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit

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
    var loginBtn:UIButton? = {
       let btn = UIButton.init(type: .custom)
        btn.setTitle("立即登录", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "#ffe35e"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(clickBtnAction(button:)), for: .touchUpInside)
        return btn
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
    
    
    var infoModel:DRCellConfingModel! {
        didSet {
            nameLabel?.text = "这是名字"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView!)
        addSubview(nameLabel!)
        addSubview(loginBtn!)
        addSubview(openVipBtn!)
        
        logoImageView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
        })
        
        nameLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((logoImageView?.snp.right)!).offset(10)
            make.centerY.equalTo(logoImageView!)
        })
        
        loginBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((logoImageView?.snp.right)!).offset(50)
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
