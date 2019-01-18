//
//  GetCodeButton.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/17.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit

class GetCodeButton: UIButton {
    var _remainTime: Int?
    var remainTime: Int? {
        get {
            return _remainTime!
        }
        set {
            _remainTime = newValue
            
            if newValue == 0 {
                self.setTitle("获取验证码", for: UIControlState.normal)
                self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                self.isAble = true
            }else{
                self.setTitle("\(_remainTime!)"+"s 后获取" , for: UIControlState.normal)
                self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
                self.isAble = false
            }
        }
    }
    
    var isAble: Bool? {
        didSet {
            //可点击
            if isAble! {
                self.isUserInteractionEnabled = true
                self.setTitleColor(logoColor, for: UIControlState.normal)

            }else{
                self.isUserInteractionEnabled = false
                self.setTitleColor(invalidColor, for: UIControlState.normal)

            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.remainTime = 0;
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
