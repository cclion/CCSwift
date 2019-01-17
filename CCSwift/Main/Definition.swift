//
//  Definition.swift
//  CCSwift
//
//  Created by job on 2019/1/16.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

// 定义颜色
func RGBColor(r:CGFloat,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}
func RGBAColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) ->UIColor{
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func RGBCOLOR_HEX(h:Int) ->UIColor {
    return RGBColor(r: CGFloat(((h)>>16) & 0xFF), g:   CGFloat(((h)>>8) & 0xFF), b:  CGFloat((h) & 0xFF))
}

