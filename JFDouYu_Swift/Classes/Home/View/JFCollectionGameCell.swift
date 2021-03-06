//
//  JFCollectionGameCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/5.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFCollectionGameCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var baseGame:BaseGameModel?{
        didSet{
            bottomLabel.text = baseGame?.tag_name
//            imageView.kf.setImage(with: URL(string: group?.icon_url ?? ""))
            
            imageView.kf.setImage(with: URL(string: baseGame?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
