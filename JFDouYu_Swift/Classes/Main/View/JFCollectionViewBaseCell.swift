//
//  JFCollectionViewBaseCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFCollectionViewBaseCell: UICollectionViewCell {
    
    //公共的控件 抽取到基类里面来
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    //公共的属性抽取出来
    // 通过子类传递给我的 anchor 来设置值
   var anchor:AnchorModel?{
        didSet{
            //校验模型是否有值 常规常规操作
            guard let anchor = anchor else { return }
            nickNameLabel.text = anchor.nickname
            
            var onlineStr:String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(onlineStr)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
        }
    }
    
}
