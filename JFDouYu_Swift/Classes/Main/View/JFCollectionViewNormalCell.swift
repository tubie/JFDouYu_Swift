//
//  JFCollectionViewNormalCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/3.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionViewNormalCell: JFCollectionViewBaseCell {

 
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //Overriding declaration requires an 'override' keyword
    //父类已经定义了该属性子类不能 一样 如果要一样的化要加 override重写
    override var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            //将属性传递给父类
             super.anchor = anchor
            roomNameLabel.text = anchor.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
