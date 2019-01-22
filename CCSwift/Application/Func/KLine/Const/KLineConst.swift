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

/// 日K线数据
//1、价格走势部分
let kLinePriceViewHeight: CGFloat = kLineViewWitdh * 0.75
let kLinePriceViewSeg: CGFloat = 10

//2、间隔
let kLineViewInterval: CGFloat = 30

//3、交易量部分
let kLineCountViewHeight: CGFloat = kLineViewWitdh * 0.25
let kLineViewHeight: CGFloat = kLinePriceViewHeight + kLineCountViewHeight + kLineViewInterval

