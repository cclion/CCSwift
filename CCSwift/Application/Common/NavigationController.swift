//
//  NavigationController.swift
//  CCSwift
//
//  Created by job on 2019/1/17.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // 隐藏二级界面的Tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1{
           viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }


}
