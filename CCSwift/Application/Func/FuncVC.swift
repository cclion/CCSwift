//
//  FuncVC.swift
//  CCSwift
//
//  Created by job on 2019/1/21.
//  Copyright © 2019 我是花轮. All rights reserved.
//

/*
 注意
 1、为了使用（复制、粘贴）方便，Func模块下的各个子模块均不使用模块外的宏定义
 
 */


import UIKit

class FuncVC: UITableViewController {

    //小功能 [[title:control]]
    let data = [["3D模型惯性旋转(月球模型)":"MoonSceneVC"],
                ["股票K线":"ViewController"],
                ["ShortCut":"ViewController"],
                ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].keys.first

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = data[indexPath.row].values.first
        let vcClass = NSObject.swiftClassFromString(className: vcName!)! as! UIViewController.Type
        let vc = vcClass.init()
        vc.title = data[indexPath.row].keys.first
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


}
