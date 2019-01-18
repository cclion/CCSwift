//
//  OauthVM.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/19.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class OauthVM: NSObject {
    
    var _masToken: String?
    var masToken: String? {
        get {
            if _masToken == nil {
                //为空
                _masToken = UserDefaults.standard.string(forKey: userDefaultsMasTokenKey)
            }
            return _masToken
        }
        set {
            _masToken = newValue
            UserDefaults.standard.set(newValue, forKey: userDefaultsMasTokenKey)
        }
    }
    var _estateToken: String?
    var estateToken: String? {
        get {
            if _estateToken == nil {
                //为空
                _estateToken = UserDefaults.standard.string(forKey: userDefaultsEstateTokenKey)
            }
            return _estateToken
        }
        set {
            _estateToken = newValue
            UserDefaults.standard.set(newValue, forKey: userDefaultsEstateTokenKey)
        }
    }
    var _account:AccountModel?
    var account: AccountModel? {
        get {
            if _account == nil {
                //为空
                  _account  = AccountModel.deserialize(from: UserDefaults.standard.dictionary(forKey: userDefaultsUesrAccountKey))
            }
            return _account
        }
        set {
            _account = newValue
            UserDefaults.standard.set(newValue!.toJSON(), forKey: userDefaultsUesrAccountKey)
        }
    }
    
    static let sharedInstance = OauthVM()
    
    // MARK: - 登录逻辑
    // 登录逻辑 = 1、访问passport拿masToken和code 2、获取estateToken
    func login(parameters: [String : Any],
               success:@escaping()->(),
               failure:@escaping()->())
     -> () {
       
        //1、访问passport拿masToken和code
        NetworkTool.sharedInstance.requestData(.post, serveType: .passport, subURLString: getMasTokenURL, parameters: parameters, success: { (result) in
            let json = JSON(result)
            self.masToken = json["access_token"].string!
            let code = json["code"].string!
           
            let parameters = ["code":code]

            //2、获取estateToken
            NetworkTool.sharedInstance.requestData(.post, serveType: .estate, subURLString: getEstateTokenURL, parameters: parameters, success: { (result) in
                self.estateToken = JSON(result)["token"]["estate_token"].string
                let json = JSON(result)["account"].dictionary
                // 用户信息
                self.account =  AccountModel.deserialize(from: json!)
                success()
            }) { (error) in
                failure()
            }
            
        }) { (error) in
            failure()
        }
        
    }
 
    
    
    
    
}
