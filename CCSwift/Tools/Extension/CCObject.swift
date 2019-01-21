//
//  CCObject.swift
//  CCSwift
//
//  Created by job on 2019/1/21.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

extension NSObject{
    
        class func swiftClassFromString(className: String) -> AnyClass! {
        
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String   //这里是坑，不要翻译oc的代码，而是去NSBundle类里面看它的api
        let className = appName! + "." + className
        
        return NSClassFromString(className)
    }
    
}
extension UIViewController{
    

    
}
