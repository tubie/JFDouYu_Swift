//
//  JFCollectionViewPrettyCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionViewPrettyCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    
    var anchor:AnchorModel?{
        didSet{
            //校验模型是否有值 常规常规操作
            guard let anchor = anchor else {return}
            nickNameLabel.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            
            var onlineStr:String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(onlineStr)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
//            iconImageView.image = UIImage(named: anchor.vertical_src)
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
