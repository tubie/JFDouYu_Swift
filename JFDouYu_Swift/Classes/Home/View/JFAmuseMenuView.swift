//
//  JFAmuseMenuView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/9.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let JFMenuID:String = "JFMenuID"

class JFAmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //经常使用 高度随着父控件的拉伸而拉伸。
//           collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: JFAmuseMenuViewCellID)
        
        collectionView.register(UINib(nibName: "JFAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: JFMenuID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.itemSize = collectionView.bounds.size
    }
    
}

extension JFAmuseMenuView{
    class func amuseMenuView() -> JFAmuseMenuView {
        return Bundle.main.loadNibNamed("JFAmuseMenuView", owner: nil, options: nil)?.first as! JFAmuseMenuView
    }
}

extension JFAmuseMenuView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JFMenuID, for: indexPath) as! JFAmuseMenuViewCell
        return cell
    }
}
