//
//  BaseAnchorViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/7.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 3)/2
private let kNormalItemH:CGFloat = kItemW * 3 / 4
private let kPrettyItemH:CGFloat = kItemW * 4 / 3
private let KCycleViewH:CGFloat = kScreenWidth * 3 / 8
private let KGameViewH:CGFloat = 90


private let KNormalCellID = "KNormalCellID"
private let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"
private let KHeaderViewH:CGFloat = 50



class BaseAnchorViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    //默认他有值的 下面要用到 baseVM的时候 就会自动解包 如果为空的话
    // 对空值进行解包的话 会奔溃
    var baseVM:BaseViewModel!
    
     lazy var collectionView:UICollectionView = {
            let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            let layout = UICollectionViewFlowLayout()
    //        layout.itemSize = CGSize(width: kItemW, height: kItemH)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = kItemMargin
            //设置组头
            layout.headerReferenceSize = CGSize(width: kScreenWidth, height: KHeaderViewH)
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
            
            let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
                  //经常使用 高度随着父控件的拉伸而拉伸。
                  collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            
    //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KNormalCellID)
            
            collectionView.register(UINib(nibName: "JFCollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalCellID)
            
            collectionView.register(UINib(nibName: "JFCollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: KPrettyCellID)
            
            
            //纯代码注册
    //         collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
    //        let nib =  UINib(nibName: "JFCollectionHeaderView", bundle: nil)
            
            //nib 注册
            collectionView.register(UINib(nibName: "JFCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
            collectionView.dataSource = self
            collectionView.delegate = self
          
            return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()

    }
    
    func loadData(){
        
    }
    
    func setupUI(){
        view.addSubview(collectionView)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = baseVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath) as! JFCollectionViewNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
           return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewID, for: indexPath) as! JFCollectionHeaderView
        headerView.anchorGroup = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}

