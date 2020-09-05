//
//  JFRecommendCycleView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/5.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let KCycleCellID = "KCycleCellID"

class JFRecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControllerView: UIPageControl!
    
    @IBOutlet weak var cycleLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:KCycleCellID)
        collectionView.dataSource = self
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cycleLayout.itemSize = collectionView.bounds.size
       
    }


}

//快速创建 创建view
extension JFRecommendCycleView{
    class func recommendCycleView() -> JFRecommendCycleView{
        return Bundle.main.loadNibNamed("JFRecommendCycleView", owner: nil, options: nil)?.first as! JFRecommendCycleView;
    }
}

extension JFRecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2  == 0 ?  UIColor.red : UIColor.purple
        return cell
    }
    
    
}
