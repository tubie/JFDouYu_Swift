//
//  JFAmuseMenuViewCell.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let JFGameCellID = "JFGameCellID"


class JFAmuseMenuViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "JFCollectionGameCell", bundle: nil), forCellWithReuseIdentifier:JFGameCellID )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
         let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW  = contentView.bounds.width / 4
        let itemH  = contentView.bounds.height / 2
         collectionViewLayout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}

extension JFAmuseMenuViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JFGameCellID, for: indexPath) as! JFCollectionGameCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
