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
    
    //定义属性
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //经常使用 高度随着父控件的拉伸而拉伸。
//           collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        collectionView.dataSource = self
        collectionView.delegate = self
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
        if groups == nil  { return 0 }
        //计算多少页的算法
        let pageNum = (groups!.count - 1) / 8 + 1
        pageController.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JFMenuID, for: indexPath) as! JFAmuseMenuViewCell
        setCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setCellDataWithCell(cell:JFAmuseMenuViewCell,indexPath:IndexPath){
        // 0-7
        // 8-15
        // 15-23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //判断越界问题 Change 'let' to 'var' to make it mutable 这个地方 endIndex是可变的  用var
        // 运算符号 要加空格
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //取出数据 再组装成一个数组
        cell.groups = Array(groups![startIndex...endIndex])

    }
}

extension JFAmuseMenuView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
