//
//  KLineConst.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//  用于记录K线竖屏版各个常亮

import Foundation

/// 视图宽度
let kLineViewWitdh: CGFloat = UIScreen.main.bounds.width

// MARK:- 日K线数据
//1、价格走势部分
/// K线价格视图高度（含两边边距）
let kLinePriceViewHeight: CGFloat = 200
/// K线价格视图内边距
let kLinePriceViewSeg: CGFloat = 10
/// K线价格视图Cell中K线柱的内边距
let kLinePriceViewCellSeg: CGFloat = 2

//2、间隔
/// K线价格视图和交易量视图间距
let kLineViewInterval: CGFloat = 30

//3、交易量部分
/// K线交易量视图高度（自身无边距）
let kLineCountViewHeight: CGFloat = kLineViewWitdh * 0.25

let kLineViewCellDefaultHeight: CGFloat = 10
/// K线视图总高度
let kLineViewHeight: CGFloat = kLinePriceViewHeight + kLineCountViewHeight + kLineViewInterval


/// K线视图价格cell reuseIdentifier
let kLinePriceRID = "KLinePriceRID"

/// K线价格视图极值发生变化
let KLinePriceExtremumChangeNotification = "KLinePriceExtremumChangeNotification"



