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
        }
    }
    lazy var pillarLayer = CAShapeLayer.init()
    
    func layoutSubViews() {
        

       
    }
    
    func configerSubViews() {
        self.contentView.layer.addSublayer(pillarLayer)
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
