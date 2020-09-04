//
//  JFCollectionViewNormalCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/3.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            iconImageView.kf.setImage(with: URL(string: anchor.vertical_src))
            nickNameLabel.text = anchor.nickname
            var onlineStr:String = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(onlineStr)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            roomNameLabel.text = anchor.room_name
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
