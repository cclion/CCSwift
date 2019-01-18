//
//  DefaultButton.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/18.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    var isAble: Bool? {
        didSet {
            //可点击
            if isAble! {
                self.isUserInteractionEnabled = true
                self.setTitleColor(UIColor.white, for: UIControlState.normal)
                self.backgroundColor = logoColor
            }else{
                self.isUserInteractionEnabled = false
                self.setTitleColor(UIColor.white, for: UIControlState.normal)
                self.backgroundColor = invalidColor
            }
        }
    }

    init(title:String) {
        super.init(frame: CGRect.zero)
        self.setTitle(title, for: UIControlState.normal)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.backgroundColor = logoColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
