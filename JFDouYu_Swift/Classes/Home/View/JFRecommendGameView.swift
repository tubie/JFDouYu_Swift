//
//  JFRecommendGameView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/5.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let JFRecommendGameCellID = "JFRecommendGameCellID"

class JFRecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups:[AnchorGroup]?{
        didSet{
            groups?.remove(at: 0)
            groups?.remove(at: 0)
            let group = AnchorGroup()
            group.tag_name = "更多"
            group.icon_url = "home_more_btn"
            groups?.append(group)
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIView.AutoresizingMask()

        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "JFCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: JFRecommendGameCellID)
    }

}

//快速创建 创建view
extension JFRecommendGameView{
    class func recommendGameView() -> JFRecommendGameView{
        return Bundle.main.loadNibNamed("JFRecommendGameView", owner: nil, options: nil)?.first as! JFRecommendGameView;
    }
}

extension JFRecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JFRecommendGameCellID, for: indexPath) as! JFCollectionGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
}
