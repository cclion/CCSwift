//
//  GlobalConst.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/17.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit

let logoColor = RGBColor(r: 0, g: 195, b: 231) //主题色
let defuleBackColor = RGBColor(r: 255, g: 255, b: 255) //页面背景
let tableViewBackColor = RGBColor(r: 247, g: 247, b: 247)//列表背景颜色
let textFieldBorderColor = RGBColor(r: 204, g: 204, b: 204) //输入框边框颜色
let invalidColor = RGBColor(r: 217, g: 217, b: 217) //按钮失效颜色

var randomColor: UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
}

// MARK: - 尺寸信息
func iPhoneX() -> Bool {
    return UIScreen.main.bounds.size.height == 812.0
}

/// 全屏宽度
let kScreenWitdh = UIScreen.main.bounds.width
/// 全屏高度，不含状态栏高度
let kScreenHeight = UIScreen.main.bounds.height
/// 状态栏默认高度
let kStatusBarHeight:CGFloat = (iPhoneX() ? 44.0 : 20.0)
/// 导航栏默认高度
let kNavBarHeight:CGFloat = 44.0
/// Tabbar默认高度
let kTabBarHeight:CGFloat = (iPhoneX() ? 83.0 : 49.0)

/// 首页底部房间列表itemg展示个数
let kAreaInfoViewRoomItemCount = 4
/// 首页底部房间列表item宽度
let kAreaInfoViewRoomItemWidth = kScreenWitdh/4
/// 首页底部房间列表item高度
let kAreaInfoViewRoomItemHeight:CGFloat = 60

// MARK: 字体篇
let CCNavigationFont = UIFont.init(name: "PingFangSC-Medium", size: 18)
let CCTitleFont = UIFont.init(name: "PingFangSC-Semibold", size: 15)
let CCTextFont = UIFont.init(name: "PingFangSC-Regular", size: 14)
let CCDescriptionFont = UIFont.init(name: "PingFangSC-Regular", size: 12)
let CCTabBarFont = UIFont.init(name: "PingFangSC-Regular", size: 10)

// MARK: 颜色篇
// | -- 通用
/// 主题色
let CCLogoColor = RGBColor(r: 0, g: 195, b: 231)
/// 页面背景
let CCDefuleBackColor = RGBColor(r: 255, g: 255, b: 255)

// | -- TableView
/// 列表背景颜色
let CCTableViewBackColor = RGBColor(r: 247, g: 247, b: 247)

// | -- TextField
/// 输入框边框颜色
let CCTextFieldBorderColor = RGBColor(r: 204, g: 204, b: 204)

// | -- button
/// 按钮正常背景颜色
let CCBtnNormalBackColor = RGBColor(r: 91, g: 166, b: 284)
/// 按钮选中背景颜色
let CCBtnSelectedBackColor = RGBColor(r: 114, g: 187, b: 249)
/// 按钮点击时背景颜色(高亮)
let CCBtnPressedBackColor = RGBColor(r: 67, g: 124, b: 191)
/// 按钮不可点击背景颜色
let CCBtnDisabledBackColor = RGBColor(r: 211, g: 211, b: 211)
/// 按钮正常文字颜色
let CCBtnNormalTitleColor = RGBColor(r: 255, g: 255, b: 255)
/// 按钮不可点击文字颜色
let CCBtnDisabledTitleColor = RGBColor(r: 180, g: 180, b: 180)


// MARK: - 持久化存储key值
let userDefaultsMasTokenKey = "masToken"
let userDefaultsEstateTokenKey = "estateToken"
let userDefaultsUesrAccountKey = "userAccount"






