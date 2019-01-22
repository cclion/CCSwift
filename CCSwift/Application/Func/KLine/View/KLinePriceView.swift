//
//  KLinePriceView.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
class KLinePriceView: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KLineVM.sharedInstance.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 创建复用cell 并且传递index
        // 传递index是因为cell还要获取旁边两个cell的数据完成均线 传递的index可以借助VM实现数据获取 
        let cell = KLinePriceCell.init(style: .default, reuseIdentifier: kLinePriceRID)
        self.findExtreNum()
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KLineVM.sharedInstance.cellHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexs = self.indexPathsForVisibleRows
        print(indexs?.count)
    }
    
    /// 找到当前列表展示的数据极值
    func findExtreNum() {
        // 获取当前展示的cells的Indexpath数组
        let indexs = self.indexPathsForVisibleRows
        // 用于记录极值是否有变化 有变化则需要刷新cell
        var isShouldRefresh = false
        
        for indexPath in indexs! {
            let data = KLineVM.sharedInstance.data[indexPath.row]
        
            let dataMax: CGFloat = CGFloat([data.highestprice, data.lowestprice, data.openprice, data.closeprice].max()!)
            let dataMin: CGFloat = CGFloat([data.highestprice, data.lowestprice, data.openprice, data.closeprice].min()!)
            
            if KLineVM.sharedInstance.priceMax == 0 || dataMax > KLineVM.sharedInstance.priceMax{
                KLineVM.sharedInstance.priceMax = dataMax
                isShouldRefresh = true
            }
            if KLineVM.sharedInstance.priceMin == 0 || dataMin < KLineVM.sharedInstance.priceMin{
                KLineVM.sharedInstance.priceMin = dataMin
                isShouldRefresh = true
            }
        }
        
        if isShouldRefresh{
            self.reloadData()
        }
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
