//
//  OauthModel.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/22.
//  Copyright © 2018 我是花轮. All rights reserved.
//

import UIKit
import HandyJSON

// 用户信息
struct AccountModel: HandyJSON {
    var phone : String = ""
    var avatar : String = ""
    var email : String = ""
    var account_name : String = ""
    var account_id : String = ""
}
