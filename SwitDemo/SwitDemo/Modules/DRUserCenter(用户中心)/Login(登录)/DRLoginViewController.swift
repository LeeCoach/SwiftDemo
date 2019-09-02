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
        title = "登录"
        
        setUI()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loginBtnAction() {

        guard mobileTF?.text != nil else {
            DRHUD.showInfo(title: "请输入手机号码")
            return
        }
        
        if viewType == .code {
            guard codeTF?.text != nil else {
                DRHUD.showInfo(title: "请输入验证码")
                return
            }
        } else {
            guard passwordTF?.text != nil else {
                DRHUD.showInfo(title: "请输入密码")
                return
            }
        }
        
        DRHUD.show()
        view.endEditing(true)
        if viewType == .code {
            
            loginBtn?.isEnabled = false
            DRNetwork.getSmsCode(mobile: (mobileTF?.text!)!, type: "1",code: codeTF?.text, act: "2") { (BaseResult) -> (Void) in
                if BaseResult.isSuccess {
                    
                    let data = BaseResult.data as? NSDictionary
                    if let smsKey = data?["smsKey"] {
                        
                        DRNetwork.userLogin(moblie: self.mobileTF!.text!, password: nil, smsKey: smsKey as? String, code: nil, type: "1", completionHandler: { (BaseResult) -> (Void) in
                            if BaseResult.isSuccess {
                                DRHUD.hide()
                                self.requestUserDetails()
                                self.loginBtn?.isEnabled = true
                            } else {
                                DRHUD.showError(title: BaseResult.msg,subtitle: nil)
                                self.loginBtn?.isEnabled = true
                            }
                        })
                        
                    } else {
                        DRHUD.showError(title: "验证失败",subtitle: nil)
                        self.loginBtn?.isEnabled = true
                    }
                    
                } else {
                    DRHUD.showError(title: BaseResult.msg,subtitle: nil)
                    self.loginBtn?.isEnabled = true
                }
            }
        } else { //密码登录
            
            loginBtn?.isEnabled = false
            DRNetwork.userLogin(moblie: mobileTF!.text!, password: passwordTF?.text, smsKey: nil, code: nil, type: "5") { (BaseResult) -> (Void) in
                if BaseResult.isSuccess {
                    DRHUD.hide()
                    self.requestUserDetails()
                    self.loginBtn?.isEnabled = true
                } else {
                    DRHUD.showError(title: BaseResult.msg, subtitle: nil)
                    self.loginBtn?.isEnabled = true
                }
            }
        }
    }
    
    @objc func changeBtnAction() {
        
        if viewType == .code {
            viewType = .password
            self.changeBtn!.setTitle("使用验证码登录", for: .normal)
            self.codeTF?.isHidden = true
            self.passwordTF?.isHidden = false
            
        } else {
            viewType = .code
            self.changeBtn!.setTitle("使用密码登录", for: .normal)
            self.codeTF?.isHidden = false
            self.passwordTF?.isHidden = true
        }
    }
    
    @objc func getVerificationCode() {
        
        guard mobileTF?.text != nil else {
            DRHUD.showInfo(title: "请输入手机号码")
            return
        }
        
        DRNetwork.getSmsCode(mobile: mobileTF!.text!, type: "1", act: "1") { (BaseResult) -> (Void) in
            if BaseResult.isSuccess {
                var timeout = 60
                let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
                timer.schedule(wallDeadline: .now(), repeating: .seconds(1))
                timer.setEventHandler {
                    timeout = timeout - 1
                    
                    if timeout <= 0 {
                        timer.cancel()
                        DispatchQueue.main.async {
                            // Run async code on the main queue
                            self.codeBtn?.setTitle("重新获取", for: .normal)
                            self.codeBtn?.isUserInteractionEnabled = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            // Run async code on the main queue
                            self.codeBtn?.setTitle("\(timeout)s", for: .normal)
                            self.codeBtn?.isUserInteractionEnabled = false
                        }
                    }
                    
                }
                timer.resume()
            } else {
                DRLog(BaseResult.msg)
            }
        }
    }
    
    // MARK: 登录成功后，重新获取用户详情
    private func requestUserDetails() {
        
        DRUserCenter.shareManager.userDetails { (loginBaseModel) in
            if loginBaseModel.message == nil  {
                DRHUD.showSuccess(title: "登录成功", subtitle: "准备关闭页面")
                
//                let model = loginBaseModel.init()
//                model.data = userModel
//                DRUserCenter.shareManager.loginHandlerCall!(model)
                self.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name(kNotification_loginOnline), object: self)
                })
            } else {
                DRHUD.showError(title: loginBaseModel.message, subtitle: nil)
            }
            
        }
    }
    
    @objc func clickBackBtnAction() {
        self.dismiss(animated: true) {
            let model = loginBaseModel.init()
            model.message = "取消登录"
            DRUserCenter.shareManager.loginHandlerCall?(model)
        }
    }
    
    @objc func lookPassworkBtnClick(btn:UIButton) {
        passwordTF?.isEnabled = false
        passwordTF?.isSecureTextEntry = btn.isSelected
        btn.isSelected = !btn.isSelected
        passwordTF?.isEnabled = true
        passwordTF?.becomeFirstResponder()
    }
    
    func setUI() {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "user_close"), for: .normal)
        btn.addTarget(self, action: #selector(clickBackBtnAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
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
        
        loginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((mobileTF?.snp.bottom)!).offset(80)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        })
        
        changeBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((loginBtn?.snp.bottom)!).offset(20)
            make.left.equalTo((mobileTF?.snp.left)!)
        })
    }
    
    lazy var mobileTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入手机号码"
        tf.textColor = UIColor.colorHexStr("#000000")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numberPad
        
        let image = UIImage.init(named: "login_mobile")
        let imageView = UIImageView.init(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image?.size.width ?? 20, height: image?.size.height ?? 20)
        tf.leftView = imageView
        tf.leftViewMode = .always
        
        return tf;
    }()
    
    lazy var codeBtn:UIButton? = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        btn.setTitle("获取验证码", for: .normal)
        btn.setTitleColor(UIColor.colorHexStr("#666666"), for: .normal)
        btn.setTitleColor(UIColor.colorHexStr("#666666"), for: .disabled)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        btn.backgroundColor = UIColor.colorHexStr("#f2f2f2")
        btn.addTarget(self, action: #selector(getVerificationCode), for: .touchUpInside)
        return btn
    }()
    
    lazy var codeTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入验证码"
        tf.textColor = UIColor.colorHexStr("#000000")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numberPad
        tf.rightView = self.codeBtn
        tf.rightViewMode = .always
        
        let image = UIImage.init(named: "login_security_code")
        let imageView = UIImageView.init(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image?.size.width ?? 20, height: image?.size.height ?? 20)
        tf.leftView = imageView
        tf.leftViewMode = .always
        return tf;
    }()
    
    lazy var passwordTF:UITextField? = {
        let tf = UITextField.init()
        tf.textAlignment = NSTextAlignment.center
        tf.font = font(size: 14)
        tf.placeholder = "请输入密码"
        tf.textColor = UIColor.colorHexStr("#000000")
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.clearButtonMode = .whileEditing
//        tf.keyboardType = .numberPad
        tf.isSecureTextEntry = true
        tf.isHidden = true
        
        let image = UIImage.init(named: "login_lock")
        let imageView = UIImageView.init(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: image?.size.width ?? 26, height: image?.size.height ?? 26)
        tf.leftView = imageView
        tf.leftViewMode = .always
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        btn.setImage(UIImage(named: "password_nolook"), for: .normal)
        btn.setImage(UIImage(named: "password_look"), for: .selected)
        btn.addTarget(self, action: #selector(lookPassworkBtnClick(btn:)), for: .touchUpInside)
        tf.rightView = btn
        tf.rightViewMode = .always
        return tf;
    }()
    
    lazy var changeBtn:UIButton? = {
       let btn = UIButton.init(type: .custom)
        btn.setTitle("使用密码登录", for: .normal)
        btn.setTitleColor(UIColor.colorHexStr("#666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(changeBtnAction), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var loginBtn:UIButton? = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.colorHexStr("#333333"), for: .normal)
        btn.backgroundColor = UIColor.colorHexStr("#ffe35e")
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        
        return btn
    }()

}
