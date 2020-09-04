//
//  JFCollectionHeaderView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/3.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionHeaderView: UICollectionReusableView {

    //空间属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //模型属性
    var anchorGroup:AnchorGroup?{
        didSet{
            titleLabel.text = anchorGroup?.tag_name
            iconImageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
