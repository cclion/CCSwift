//
//  KLineView.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import HandyJSON
class KLineView: UIView {

    var priceView = KLinePriceView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(priceView)
        priceView.transform = CGAffineTransform( rotationAngle: CGFloat(.pi * 0.5));
        priceView.frame = CGRect.init(x: 0, y: 0, width: kLineViewWitdh, height: kLinePriceViewHeight)
                    
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

