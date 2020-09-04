//
//  RecommendViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/2.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 3)/2
private let kNormalItemH:CGFloat = kItemW * 3 / 4
private let kPrettyItemH:CGFloat = kItemW * 4 / 3

private let KNormalCellID = "KNormalCellID"
private let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"
private let KHeaderViewH:CGFloat = 50

class RecommendViewController: UIViewController {
    
    //懒加载一个对象
    private lazy var recommendVM:JFRecommenViewModel =  JFRecommenViewModel()
    
    private lazy var collectionView:UICollectionView = {
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
                
        setUpUI()
        
        loadData()
        
       
        // Do any additional setup after loading the view.
    }

}

extension RecommendViewController{
    func setUpUI(){
        view.addSubview(collectionView)
    }
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //取出组
        let group = recommendVM.anchorGroups[section]
        //取出组的 anchors的数量
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalCellID, for: indexPath)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID, for: indexPath)
        let group = recommendVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}

extension RecommendViewController{
    private func loadData(){
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
    }
}
