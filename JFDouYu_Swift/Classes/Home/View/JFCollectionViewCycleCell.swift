//
//  JFCollectionViewCycleCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/5.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Kingfisher

class JFCollectionViewCycleCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomLabel: UILabel!
    var cycleModel:JFCycleModel?{
        didSet{
            bottomLabel.text = cycleModel?.title ?? ""
           imageView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""))
            
//            guard let  cycleModel = cycleModel else {return}
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
