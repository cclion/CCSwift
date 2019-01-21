//
//  OauthTextField.swift
//  SwiftPhantomLab
//
//  Created by job on 2018/10/17.
//  Copyright © 2018年 我是花轮. All rights reserved.
//

import UIKit


class OauthTextField: UITextField {

   public init(Placeholder placeholder:String) {
    super.init(frame: CGRect.zero)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = textFieldBorderColor.cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.placeholder = placeholder
    self.leftViewMode = UITextField.ViewMode.always
        self.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 0))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
