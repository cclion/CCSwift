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

        self.setupChildController(ViewController(), iconImageStr: "Home", title: "首页")
        self.setupChildController(ViewController(), iconImageStr: "Home", title: "首页")
        self.setupChildController(ViewController(), iconImageStr: "Home", title: "首页")
        self.setupChildController(ViewController(), iconImageStr: "Home", title: "首页")

    }
    
    // icon尺寸 1X 22
    func setupChildController(_ childController: UIViewController,
                           iconImageStr: String,
                           title: String) {
        
        childController.tabBarItem.image = UIImage.init(named: iconImageStr)
        childController.tabBarItem.selectedImage = UIImage.init(named: iconImageStr)
        childController.tabBarItem.title = title
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:logoColor], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:logoColor], for: .selected)
        self.addChild(childController)
    }
    

}
