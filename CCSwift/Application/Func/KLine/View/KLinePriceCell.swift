//
//  KLinePriceCell.swift
//  CCSwift
//
//  Created by job on 2019/1/22.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit
import SnapKit

class KLinePriceCell: UITableViewCell {
    
    let maxLabel = UILabel.init()
    let minLabel = UILabel.init()
    
    var index: Int? {
        didSet{
            let data = KLineVM.sharedInstance.data[index!]
            currData = data
        }
    }
    var currData: KLineModel? {
        didSet{
            // 如果极大值为0 说明当前最大值还没有计算出来 不需要渲染了
            if KLineVM.sharedInstance.priceMax == 0 {
                return
            }
            self.layoutSubViews()
        }
    }
    lazy var pillarLayer = CAShapeLayer.init()
    lazy var lineLayer = CAShapeLayer.init()

    @objc func layoutSubViews() {
        
        if currData == nil{
            return
        }
        
        let pillarLayerPath = UIBezierPath.init(rect: KLineVM.sharedInstance.getKLinePriceRect(currData!))
        pillarLayer.path = pillarLayerPath.cgPath
        
        let lineLayerPath = UIBezierPath.init()
        lineLayerPath.move(to: CGPoint.init(x: KLineVM.sharedInstance.getKLinePriceTopDis(CGFloat(currData!.highestprice)), y: KLineVM.sharedInstance.cellHeight / 2))
        lineLayerPath.addLine(to: CGPoint.init(x: KLineVM.sharedInstance.getKLinePriceTopDis(CGFloat(currData!.lowestprice)), y: KLineVM.sharedInstance.cellHeight / 2))
        lineLayer.path = lineLayerPath.cgPath
        
        // 升了
        if currData!.closeprice >= currData!.openprice {
            pillarLayer.fillColor = UIColor.red.cgColor
            lineLayer.strokeColor = UIColor.red.cgColor
        }else{
            pillarLayer.fillColor = UIColor.green.cgColor
            lineLayer.strokeColor = UIColor.green.cgColor
        }
            
    }
    
    func configerSubViews() {
        
        lineLayer.lineWidth = 1

        
        self.contentView.layer.addSublayer(pillarLayer)
        self.contentView.layer.addSublayer(lineLayer)

        self.addSubview(maxLabel)
        self.addSubview(minLabel)
        maxLabel.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        maxLabel.textColor = UIColor.red
        minLabel.frame = CGRect.init(x: 100, y: 0, width: 100, height: 20)
        minLabel.textColor = UIColor.red

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    
        let notificationName = Notification.Name(rawValue: KLinePriceExtremumChangeNotification)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(layoutSubViews),
                                               name: notificationName, object: nil)
        
        self.configerSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
