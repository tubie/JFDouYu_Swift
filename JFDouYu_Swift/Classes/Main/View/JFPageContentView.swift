//
//  JFPageContentView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/23.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let KCcontentCellID = "KCcontentCellID"

class JFPageContentView: UIView {
    
    private var childVcs:[UIViewController]
    /*
     用weak修饰 是可选类型 用 “？”修饰
     'weak' variable should have optional type 'UIViewController?'
     */
    private weak var parentViewController:UIViewController?
    
    private lazy var collectionView:UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        
        /*
         weak self 是可选类型
         self.bounds.size self?.bounds.size 也是可选类型 但是 layout.itemSize 这个是确定类型
         (self?.bounds.size)!  “!”强制解包
         */
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let frame:CGRect = .zero
        let collectionView  = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KCcontentCellID)
        return collectionView
    }()

   
    //构造函数改成可选类型
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
        self.childVcs = childVcs
        //可选类型 赋值给可选类型 OK的
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JFPageContentView{
    private func setupUI(){
        //将所有的子控制器加到父控制器中
        for childvc in childVcs {
            //如果是可选类型那么就是 要用可选链来调用
            parentViewController?.addChild(childvc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//遵守UICOllectionView 的datasource
extension JFPageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCcontentCellID, for: indexPath)
        
        //cell会循环引用 先移除
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //给cell设置内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
    
    
}
