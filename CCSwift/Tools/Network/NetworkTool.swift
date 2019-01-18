//
//  NetworkTool.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/18.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
    case put
    case delete
}

enum ServeType {
    case mas
    case estate
    case passport
}

class NetworkTool {
    
    static let sharedInstance = NetworkTool()
    
    func requestData(
        _ type : MethodType,
        serveType : ServeType,
        subURLString : String,
        parameters : [String : Any]? = nil,
        success:@escaping(_ response:[String:AnyObject])->(),
        failure:@escaping(_ error:Error)->())
        -> () {
            
            let method : HTTPMethod
            switch type {
            case .get:
                method = .get
                break
            case .post:
                method = .post
                break
            case .put:
                method = .put
                break
            default:
                method = .get
            }
            
            var header : HTTPHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            header["Accept"] = "application/json"

            let baseURL : String
            switch serveType {
            case .mas:
                baseURL = masBaseURL
                
                if OauthVM.sharedInstance.masToken != nil{
                    header["Authorization"] = "bearer " + OauthVM.sharedInstance.masToken!}
                break
            case .estate:
                baseURL = estateBaseURL
                if OauthVM.sharedInstance.estateToken != nil{
                    header["Authorization"] = "bearer " + OauthVM.sharedInstance.estateToken!}
                break
            case .passport:
                baseURL = passPortBaseURL
                break
            }
            
            let requestURL = baseURL + subURLString
            
            Alamofire.request(
                requestURL,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: header
                ).responseJSON { (response) in
                if response.result.isSuccess{
                    if let value = response.result.value as? [String : AnyObject]{
                        success(value)
                    }
                }else{
                    failure(response.error!)
                }
            }
    }
    
    
   
}
