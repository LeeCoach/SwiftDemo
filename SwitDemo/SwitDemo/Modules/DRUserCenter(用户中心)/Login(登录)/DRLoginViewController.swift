//
//  DRLoginViewController.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/19.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

class DRLoginViewController: DRViewController {
    
    enum loginType:Int {
        case code
        case password
    }
    
    var viewType:loginType = .code
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loginBtnAction() {
        
        guard (mobileTF?.text!.count)! > 0 else {
            
            return
        }
        
    }
    
    @objc func changeBtnAction() {
        
        if viewType == .code {
            viewType = .password
            self.changeBtn!.setTitle("使用密码登录", for: .normal)
        } else {
            viewType = .code
            self.changeBtn!.setTitle("使用验证码登录", for: .normal)
        }
    }
    
    func setUI() {
        
        self.view.addSubview(mobileTF!)
        view.addSubview(codeTF!)
        view.addSubview(passwordTF!)
        view.addSubview(changeBtn!)
        view.addSubview(loginBtn!)
        
        mobileTF?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        })
        
        codeTF?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileTF?.snp.bottom)!).offset(20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        })
        
        passwordTF?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileTF?.snp.bottom)!).offset(20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(30)
        })
        
        changeBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileTF?.snp.bottom)!).offset(60)
            make.left.equalTo((mobileTF?.snp.left)!)
        })
        
        loginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileTF?.snp.bottom)!).offset(80)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        })
    }
    
    lazy var mobileTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入手机号码"
        tf.textColor = UIColor.init(hexString: "#f2f2f2")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return tf;
    }()
    
    lazy var codeTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入验证码"
        tf.textColor = UIColor.init(hexString: "#f2f2f2")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return tf;
    }()
    
    lazy var passwordTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入密码"
        tf.textColor = UIColor.init(hexString: "#f2f2f2")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        return tf;
    }()
    
    lazy var changeBtn:UIButton? = {
       let btn = UIButton.init(type: .custom)
        btn.setTitle("使用密码登录", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "#666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(changeBtnAction), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var loginBtn:UIButton? = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        btn.backgroundColor = UIColor.init(hexString: "#ffe35e")
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        
        return btn
    }()

}
