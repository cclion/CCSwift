//
//  KLinePriceView.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
class KLinePriceView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var cellLastHeight = KLineVM.sharedInstance.cellHeight
    
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "max---" + String.init(format:"%.2f",KLineVM.sharedInstance.priceMax) + "min---" + String.init(format:"%.2f",KLineVM.sharedInstance.priceMin )
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KLineVM.sharedInstance.cellHeight
    }
    
    /// 🔥找到当前列表展示的数据极值
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
    
    @objc func pinchAction(pinchGes: UIPinchGestureRecognizer) {
        print(pinchGes.state)
        print(pinchGes.scale)
        print(pinchGes.velocity)
        
        // 滑动开始 记录一下当前cell的高度
        if pinchGes.state == .began {
            cellLastHeight = KLineVM.sharedInstance.cellHeight
        }
        
        // 滑动过程中 动态修改cell的宽度
        if (pinchGes.numberOfTouches) == 2 && (pinchGes.state == .changed){
            //计算当前捏合后cell的应该宽度
            let tempHeight = cellLastHeight * pinchGes.scale
            
            if tempHeight != cellLastHeight && tempHeight >= 10 && tempHeight <= 30{
                 // 🔥计算捏合中心，根据中心点，确定放大位置
                let pOne = pinchGes.location(ofTouch: 0, in: self)
                let pTwo = pinchGes.location(ofTouch: 1, in: self)
                let center = CGPoint.init(x: (pOne.x+pTwo.x)/2, y: (pOne.y+pTwo.y)/2)
                let indexPath = self.indexPathForRow(at: center) ;//获取响应的长按的indexpath
                if indexPath == nil {
                    return
                }
             
                // 🔥小学知识用到了 具体计算方式在文章中有讲
                // 变化之前
                let y1 = CGFloat(indexPath!.row) * KLineVM.sharedInstance.cellHeight;
                let o1 = self.contentOffset.y;
                let h1 = KLineVM.sharedInstance.cellHeight * 0.5;

                // 变化之后
                let y2 = CGFloat(indexPath!.row) * tempHeight;
                let h2 = tempHeight * 0.5;

                let o2 = y2 + h2 - y1 + o1 - h1;
            
                KLineVM.sharedInstance.cellHeight = tempHeight
                self.reloadData()
                // 修改偏移量 使中心点一直处于中心 注意设置 estimatedRowHeight、estimatedSectionHeaderHeight、estimatedSectionFooterHeight来保证contentOffset可用
                self.contentOffset = CGPoint.init(x: 0, y: o2)
            }
        }
        
        if pinchGes.state == .ended ||  pinchGes.state == .recognized{
            cellLastHeight = KLineVM.sharedInstance.cellHeight
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
        
        
        let pinchGes = UIPinchGestureRecognizer.init(target: self, action:  #selector(pinchAction(pinchGes:)))
        self.addGestureRecognizer(pinchGes)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
