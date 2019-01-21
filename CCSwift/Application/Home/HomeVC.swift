//
//  HomeVC.swift
//  CCSwift
//
//  Created by job on 2019/1/17.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import DNSPageView

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        
        // 1.创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScaleEnabled = true
        style.isTitleViewScrollEnabled = true
        // 2.设置标题内容
        let titles = ["牢骚", "算法", "设计模式", "Linux", "Swift", "Objective-C", "Go", "PHP" ]
        // 3.创建每一页对应的controller
        let childViewControllers: [ViewController] = titles.map { _ -> ViewController in
            let controller = ViewController()
            controller.view.backgroundColor = randomColor
            return controller
        }
        let size = UIScreen.main.bounds.size
        // 4.创建对应的DNSPageView，并设置它的frame
        let pageView = DNSPageView(frame: CGRect(x: 0, y: 64, width: size.width, height: size.height - 64 - 50), style: style, titles: titles, childViewControllers: childViewControllers)
        view.addSubview(pageView)

    }
  


}
