//
//  KLineView.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import HandyJSON

protocol KLineViewDelegate {
    
    func kLineViewDidScroll(_ tableView: UITableView)
    func kLineViewDidPinch(_ tableView: UITableView)
    func kLineViewDidHandleLong(_ tableView: UITableView)

}


class KLineView: UIView {
 
    var priceView = KLinePriceView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .plain)
    var volumeView = KLineVolumeView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: .plain)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(priceView)
        self.addSubview(volumeView)

        priceView.layer.borderWidth = 1
        volumeView.layer.borderWidth = 1

        priceView.transform = CGAffineTransform( rotationAngle: CGFloat(.pi * 0.5));
        volumeView.transform = CGAffineTransform( rotationAngle: CGFloat(.pi * 0.5));

        priceView.frame = CGRect.init(x: 0, y: 0, width: kLineViewWitdh, height: kLinePriceViewHeight)
        volumeView.frame = CGRect.init(x: 0, y: kLinePriceViewHeight + kLineViewInterval, width: kLineViewWitdh, height: kLineVolumeViewHeight)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

