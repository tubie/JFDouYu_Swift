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



class AmuseViewController: BaseAnchorViewController, UICollectionViewDelegateFlowLayout {
    
    private lazy var amuseViewModel:JFAmuseViewModel = JFAmuseViewModel()
    
    
    //Overriding non-@objc declarations from extensions is not supported
    // 原因： 不支持从扩展中覆盖non-@objc声明
    // 解决：将方法写到主类
    
    override func loadData() {
           //给父类的 baseVM 赋值
              baseVM = amuseViewModel
              
           //请求数据
              amuseViewModel.requestAmuseData {
                  self.collectionView.reloadData()
              }
       }
    
    //对父类的 cell大小布局 重写
     override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
           return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}





