//
//  FunnyViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 3)/2
private let kNormalItemH:CGFloat = kItemW * 3 / 4

class FunnyViewController: BaseAnchorViewController {
    
    private lazy var funnyVM:JFFunnyViewModel = JFFunnyViewModel()
    
    override func loadData() {
        baseVM = funnyVM

        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

}


