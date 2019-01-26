//
//  KLineVolumeView.swift
//  CCSwift
//
//  Created by job on 2019/1/24.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

class KLineVolumeView: UITableView, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return KLineVM.sharedInstance.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KLineVolumeCell.init(style: .default, reuseIdentifier: kLineVolumeRID)
        // 🔥渲染之前先计算出当前页面即将展示的所有数据的极值
        self.findExtreNum()
        cell.index = indexPath.row

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KLineVM.sharedInstance.cellHeight
    }
    
    /// 🔥找到当前列表展示的数据极值
    func findExtreNum() {
        // 获取当前展示的cells的Indexpath数组
        let indexs = self.indexPathsForVisibleRows
        
        // 用于记录极值是否有变化 有变化则需要刷新cell
        var max: CGFloat = 0
        
        for indexPath in indexs! {
            let data = KLineVM.sharedInstance.data[indexPath.row]
            
            if max == 0 || CGFloat(data.turnovervol) > max{
                max =  CGFloat(data.turnovervol)
            }
            
        }
        
        // 🔥极值变化 发送通知
        if KLineVM.sharedInstance.volumeMax == 0 || max != KLineVM.sharedInstance.volumeMax{
            KLineVM.sharedInstance.volumeMax = max
            
            let notificationName = Notification.Name(rawValue: KLineVolumeExtremumChangeNotification)
            NotificationCenter.default.post(name: notificationName, object: self,
                                            userInfo: nil)
        }
    }
 
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        
        // 🔥 为了保证contentOffset生效
        self.estimatedRowHeight = 0;// default is UITableViewAutomaticDimension, set to 0 to disable
        self.estimatedSectionHeaderHeight = 0;// default is UITableViewAutomaticDimension, set to 0 to disable
        self.estimatedSectionFooterHeight = 0; // default is UITableViewAutomaticDimension, set to 0 to disable
        
        
//        let pinchGes = UIPinchGestureRecognizer.init(target: self, action:  #selector(pinchAction(pinchGes:)))
//        self.addGestureRecognizer(pinchGes)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
