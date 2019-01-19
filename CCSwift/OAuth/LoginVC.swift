//
//  LoginVC.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/17.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyTimer
import Toast_Swift




class LoginVC: UIViewController,UITextFieldDelegate {

    lazy var phoneText = OauthTextField.init(Placeholder: "请输入手机号")
    lazy var codeText = OauthTextField.init(Placeholder: "请输入验证码")
    lazy var loginBtn = DefaultButton.init(title: "登录")
    lazy var codeBtn: GetCodeButton = {
        let codeBtn = GetCodeButton()
        codeBtn.addTarget(self, action: #selector(getCode), for: UIControl.Event.touchUpInside)
        return codeBtn
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.phoneText {

            var text = textField.text
            let rag = text?.toRange(range)
            text = text?.replacingCharacters(in: rag!, with: string)
            return text!.count <= 11
            
        }else  if (textField == self.codeText) {
            var text = textField.text
            let rag = text?.toRange(range)
            text = text?.replacingCharacters(in: rag!, with: string)
            return text!.count <= 4
        }
        return true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "登录"
        
        self.view.addSubview(phoneText)
        self.view.addSubview(codeText)
        self.view.addSubview(codeBtn)
        self.view.addSubview(loginBtn)
        
        phoneText.delegate = self
        codeText.delegate = self
        phoneText.addTarget(self, action: #selector(reload), for: UIControl.Event.editingChanged)
        codeText.addTarget(self, action: #selector(reload), for: UIControl.Event.editingChanged)
        loginBtn.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        
        phoneText.text = "15600770578"
        codeText.text = "9527"
        
        phoneText.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(kScreenWitdh * 0.8)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-30)
        }
        codeText.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(kScreenWitdh * 0.8)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(40)
        }
        codeBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(90)
            make.height.equalTo(15)
            make.right.equalTo(self.codeText).offset(-16)
            make.centerY.equalTo(self.codeText)
        }
        loginBtn.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(kScreenWitdh * 0.8)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.codeText.snp.bottom).offset(50)
        }
        
        self.reload()
        
    }
    @objc func getCode() -> Void {
        
        let parameters = ["phone":self.phoneText.text!]
        self.navigationController?.view.makeToastActivity(.center)
        NetworkTool.sharedInstance.requestData(.post, serveType: .passport, subURLString: getCodeURL, parameters: parameters, success: { (result) in
            debugPrint(result)
            
            //改变按钮效果
            var remainTime = 60
            let timer = Timer.init(timeInterval: 1, repeats: true) { (timer) in
                remainTime = remainTime - 1
                
                self.codeBtn.remainTime = remainTime
                if remainTime == 0{
                    timer.invalidate()
                }
            }
            timer.start(modes: RunLoop.Mode.default)
             self.navigationController?.view.hideToastActivity()
        }) { (error) in
             self.navigationController?.view.hideToastActivity()
        }
        

    }

    @objc func reload() -> Void {
        if self.phoneText.text!.count >= 11 {
            self.codeBtn.isAble = true
        }else{
            self.codeBtn.isAble = false
        }
        
        if self.phoneText.text!.count >= 11 && self.codeText.text!.count >= 4{
            self.loginBtn.isAble = true
        }else{
            self.loginBtn.isAble = false

        }
    }
    @objc func login() -> Void {
        
        let parameters = ["client_id":"5b45246d2d1f5095bc00a1786f6629865211f52cf8bd4e6b4df8e1c2e11b863b",
                          "grant_type":"password",
                          "phone":self.phoneText.text!,
                          "verification_code":self.codeText.text!
                          ]
        OauthVM.sharedInstance.login(parameters: parameters, success: {
            self.navigationController?.dismiss(animated: true, completion: {
            })
            
        }) {
            
        }

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
