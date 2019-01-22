//
//  KLineViewModel.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import SwiftyJSON

class KLineVM: NSObject {
    static let sharedInstance = KLineVM()
    
    lazy var data: [KLineModel] = {

        let path = Bundle.main.path(forResource: "KLineData.plist", ofType: nil)
        let dataDict = NSDictionary(contentsOfFile: path!)
        let dataJson = JSON(dataDict!)
        let dataStr: String = dataJson["data"].rawString()!
        let dataKLine = [KLineModel].deserialize(from: dataStr) as! [KLineModel]
        return dataKLine
        
    }()
    
    /// cell高度
    var cellHeight = kLineViewCellDefaultHeight
    /// price极高值 默认0
    var priceMax: CGFloat = 0
    /// price极高值 默认0
    var priceMin: CGFloat = 0
    
//    func getKLineLeftDis(_ data: CGFloat) -> CGFloat {
//        
//    }
    
    
}
