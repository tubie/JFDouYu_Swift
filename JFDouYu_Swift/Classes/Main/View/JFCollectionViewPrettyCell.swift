//
//  JFCollectionViewPrettyCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionViewPrettyCell: JFCollectionViewBaseCell {

  
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor:AnchorModel?{
        didSet{
            //校验模型是否有值 常规常规操作
            guard let anchor = anchor else {return}

            //将属性传递给父类
            super.anchor = anchor
            
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
