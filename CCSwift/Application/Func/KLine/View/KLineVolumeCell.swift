
//
//  KLineVolumeCell.swift
//  CCSwift
//
//  Created by job on 2019/1/24.
//  Copyright © 2019 我是花轮. All rights reserved.
//

import UIKit

class KLineVolumeCell: UITableViewCell {

    let maxLabel = UILabel.init()

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

    
    @objc func layoutSubViews() {
        
        if currData == nil{
            return
        }
        let pillarLayerPath = UIBezierPath.init(rect: KLineVM.sharedInstance.getKLineVolumeRect(currData!))
        pillarLayer.path = pillarLayerPath.cgPath

        maxLabel.text = String.init(format:"%.2f",KLineVM.sharedInstance.volumeMax) + "---" + String.init(format:"%.2f",CGFloat((currData?.turnovervol)!))
        
    }
    
    func configerSubViews() {

        self.contentView.layer.addSublayer(pillarLayer)
        self.addSubview(maxLabel)
        maxLabel.frame = CGRect.init(x: 0, y: 0, width: 200, height: 20)
        maxLabel.textColor = UIColor.red
        maxLabel.font = UIFont.systemFont(ofSize: 10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let notificationName = Notification.Name(rawValue: KLineVolumeExtremumChangeNotification)
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(layoutSubViews),
                                               name: notificationName, object: nil)
        
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
