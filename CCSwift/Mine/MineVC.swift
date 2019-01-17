//
//  MineVC.swift
//  CCSwift
//
//  Created by job on 2019/1/17.
//  Copyright © 2019 我是花轮. All rights reserved.
//  登录入口、个人信息设置、下拉动画、修改状态栏颜色

import UIKit
import SnapKit

class MineVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.backgroundView?.addSubview(self.headerImageView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    //修改状态栏颜色
    //1、在Info.plist中添加 UIViewControllerBasedStatusBarAppearance 为YES
    //2、添加下面方法
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK:UITableViewDelegate&&UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = kScreenWitdh
        let yOffect = scrollView.contentOffset.y + 220
        print(yOffect)
        // 下拉时
        if yOffect<0 {
            let totalOffset = 200 - yOffect
            let f = totalOffset / 200
            self.headerImageView.frame = CGRect.init(x: (-(width * f - width) / 2), y: 0, width: width * f, height: totalOffset)
        }
        // 上拉时
        if yOffect>=0 {
            self.headerImageView.frame = CGRect.init(x: 0, y: -yOffect, width: kScreenWitdh, height: 200)
        }
    }
    
    //MARK:懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWitdh, height: kScreenHeight - 50))
        tableView.delegate = self
        tableView.dataSource = self
        // 修改tableView的初始展示区域
        tableView.contentInset = UIEdgeInsets.init(top: 200, left: 0, bottom: 0, right: 0)
        // 修改tableView的初始滑动区域
//        tableView.scrollIndicatorInsets = tableView.contentInset
        // 初始化tableView的背景 默认无
        tableView.backgroundView = UIView()
        return tableView
    }()
    lazy var headerImageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWitdh, height: 200));
        imageView.image = UIImage.init(named: "icon_mine_headerImage")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    

}
