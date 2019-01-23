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
    
    func layoutSubViews() {
        
        let pillarLayerPath = UIBezierPath.init(rect: KLineVM.sharedInstance.getKLineRect(currData!))
        pillarLayer.path = pillarLayerPath.cgPath
        
        maxLabel.text = String.init(format:"%.2f",KLineVM.sharedInstance.priceMax) + "---" + String.init(format:"%.2f",CGFloat([currData!.openprice, currData!.closeprice].max()!))
        minLabel.text = String.init(format:"%.2f",CGFloat([currData!.openprice, currData!.closeprice].min()!)) + "---" + String.init(format:"%.2f",KLineVM.sharedInstance.priceMin )
       
    }
    
    func configerSubViews() {
        self.contentView.layer.addSublayer(pillarLayer)
        self.addSubview(maxLabel)
        self.addSubview(minLabel)
        maxLabel.frame = CGRect.init(x: 0, y: 0, width: 100, height: 20)
        maxLabel.textColor = UIColor.red
        minLabel.frame = CGRect.init(x: 100, y: 0, width: 100, height: 20)
        minLabel.textColor = UIColor.red

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configerSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
