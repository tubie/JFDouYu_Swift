//
//  JFPageContentView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/23.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let KCcontentCellID = "KCcontentCellID"

//标明只能被类遵守  （如果不写也可以被 结构体，枚举遵守 不建议）这样不能把代理属性定义为可选类型
//定义一个协议
protocol JFPageContentViewDelegate : class {
    //声明一个协议的方法
    func JFPageContentViewScrollWith(pageContentView:JFPageContentView,progress:CGFloat, sourceIndex:Int,targetIndex:Int)
}

class JFPageContentView: UIView {
    
    weak var delegate:JFPageContentViewDelegate?
    
    private var childVcs:[UIViewController]
    
    private var startOffSetX:CGFloat = 0
    /*
     用weak修饰 是可选类型 用 “？”修饰
     'weak' variable should have optional type 'UIViewController?'
     */
    
    private var isForbidScrollDelegate:Bool = false
    
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
        collectionView.delegate = self
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

extension JFPageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffSetX =  scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (isForbidScrollDelegate) {return}
        
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targetIndex:Int = 0
        
        //判断左滑还是右滑
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW  = scrollView.bounds.width
        if startOffSetX > currentOffSetX { //左滑
            //计算progress
//            floor 取整
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            
            //计算当前的 sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            
            //计算target
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //如果完全滑过去
            if currentOffSetX - startOffSetX ==  scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        }else{ //右滑
            progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            
            //计算target
            targetIndex = Int(currentOffSetX / scrollViewW)
            
            //计算当前的 sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex) ")
        
        delegate?.JFPageContentViewScrollWith(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)

        
        
    }
}



//对外暴露的方法
extension JFPageContentView{
    func setCurrentIndex(currentIndex:Int) {
        
        //禁止执行scroll的代理
        isForbidScrollDelegate = true
        
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        //设置collectionview的偏移量
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
