//
//  AmuseViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 3)/2
private let kNormalItemH:CGFloat = kItemW * 3 / 4
private let kTopHeaderViewH:CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    private lazy var amuseMenuView:JFAmuseMenuView = {
        let  view = JFAmuseMenuView.amuseMenuView()
        view.frame = CGRect(x: 0, y: -kTopHeaderViewH, width: kScreenWidth, height: kTopHeaderViewH)
        return view
        }()
    
    private lazy var amuseViewModel:JFAmuseViewModel = JFAmuseViewModel()
    
    
    //Overriding non-@objc declarations from extensions is not supported
    // 原因： 不支持从扩展中覆盖non-@objc声明
    // 解决：将方法写到主类
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(amuseMenuView)
        
        //经常使用 高度随着父控件的拉伸而拉伸。
//        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.contentInset = UIEdgeInsets(top:kTopHeaderViewH , left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
           //给父类的 baseVM 赋值
              baseVM = amuseViewModel
           //请求数据
              amuseViewModel.requestAmuseData {
                  self.collectionView.reloadData()
                
                var tmpGroups = self.amuseViewModel.anchorGroups
                tmpGroups.removeFirst()
                self.amuseMenuView.groups = tmpGroups
              }
       }
//
//    //对父类的 cell大小布局 重写
//     override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//           return CGSize(width: kItemW, height: kNormalItemH)
//    }
    
}





