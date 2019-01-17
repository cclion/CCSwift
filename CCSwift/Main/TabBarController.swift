//
//  TabBarController.swift
//  CCSwift
//
//  Created by job on 2019/1/16.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.setupChildController(HomeVC(), iconImageStr: "icon_tabbar_home", title: "首页")
        self.setupChildController(ViewController(), iconImageStr: "icon_tabbar_QRcode", title: "扫描")
        self.setupChildController(ViewController(), iconImageStr: "icon_tabbar_other", title: "其他")
        self.setupChildController(MineVC(), iconImageStr: "icon_tabbar_mine", title: "我的")


    }
    
   
    func setupChildController(_ childController: UIViewController,
                           iconImageStr: String,
                           title: String) {
        
        childController.tabBarItem.image = UIImage.init(named: iconImageStr)
        childController.tabBarItem.selectedImage = UIImage.init(named: iconImageStr)
        childController.tabBarItem.title = title
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:logoColor], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:logoColor], for: .selected)
        self.addChild(UINavigationController.init(rootViewController: childController))
    }
    

}
