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
    
    @IBOutlet weak var moreBtn: UIButton!
    //模型属性
    var anchorGroup:AnchorGroup?{
        didSet{
//            guard let anchorGroup = anchorGroup else { return }
            titleLabel.text = anchorGroup?.tag_name
            
//            iconImageView.kf.setImage(with: URL(string: anchorGroup.icon_url))
            iconImageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//快速创建 JFCollectionHeaderView和 cell 公用
extension JFCollectionHeaderView{
    class func collectionHeaderView() -> JFCollectionHeaderView {
        return Bundle.main.loadNibNamed("JFCollectionHeaderView", owner: nil, options: nil)?.first as! JFCollectionHeaderView
    }
}
