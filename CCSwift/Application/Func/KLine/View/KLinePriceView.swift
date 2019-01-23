//
//  KLinePriceView.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
class KLinePriceView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    let maxLabel = UILabel.init()
    let minLabel = UILabel.init()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KLineVM.sharedInstance.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 创建复用cell 并且传递index
        // 传递index是因为cell还要获取旁边两个cell的数据完成均线 传递的index可以借助VM实现数据获取 
        let cell = KLinePriceCell.init(style: .default, reuseIdentifier: kLinePriceRID)
        // 🔥渲染之前先计算出当前页面即将展示的所有数据的极值
        self.findExtreNum()
        cell.index = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "max---" + String.init(format:"%.2f",KLineVM.sharedInstance.priceMax) + "min---" + String.init(format:"%.2f",KLineVM.sharedInstance.priceMin )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KLineVM.sharedInstance.cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let mainQueue = DispatchQueue.main
        mainQueue.async {
             self.findExtreNum()
        }
    }
    
    /// 找到当前列表展示的数据极值
    func findExtreNum() {
        // 获取当前展示的cells的Indexpath数组
        let indexs = self.indexPathsForVisibleRows
      
        // 用于记录极值是否有变化 有变化则需要刷新cell

        var max: CGFloat = 0
        var min: CGFloat = 0
      
        for indexPath in indexs! {
            let data = KLineVM.sharedInstance.data[indexPath.row]
        
            let dataMax: CGFloat = CGFloat([data.highestprice, data.lowestprice].max()!)
            let dataMin: CGFloat = CGFloat([data.highestprice, data.lowestprice].min()!)
            
            if max == 0 || dataMax > max{
                max = dataMax
            }
            if min == 0 || dataMin < min{
                min = dataMin
            }
        }
        
        // 🔥极值变化 发送通知
        if KLineVM.sharedInstance.priceMax == 0 || max != KLineVM.sharedInstance.priceMax{
            KLineVM.sharedInstance.priceMax = max
            
            let notificationName = Notification.Name(rawValue: KLinePriceExtremumChangeNotification)
            NotificationCenter.default.post(name: notificationName, object: self,
                                            userInfo: nil)
            
        }
        if KLineVM.sharedInstance.priceMin == 0 || min != KLineVM.sharedInstance.priceMin{
            KLineVM.sharedInstance.priceMin = min
            
            let notificationName = Notification.Name(rawValue: KLinePriceExtremumChangeNotification)
            NotificationCenter.default.post(name: notificationName, object: self,
                                            userInfo: nil)
        }
        
    }
    
    func configerSubViews() {
       
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
