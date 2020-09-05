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
    
    var group:AnchorGroup?{
        didSet{
            bottomLabel.text = group?.tag_name
//            imageView.kf.setImage(with: URL(string: group?.icon_url ?? ""))
            imageView.kf.setImage(with: URL(string: group?.icon_url ?? ""), placeholder: UIImage(named: "home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
