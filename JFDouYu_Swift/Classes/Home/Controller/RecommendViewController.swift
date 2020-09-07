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
private let KCycleViewH:CGFloat = kScreenWidth * 3 / 8
private let KGameViewH:CGFloat = 90


private let KNormalCellID = "KNormalCellID"
private let KPrettyCellID = "KPrettyCellID"
private let KHeaderViewID = "KHeaderViewID"
private let KHeaderViewH:CGFloat = 50

class RecommendViewController: BaseAnchorViewController, UICollectionViewDelegateFlowLayout {
    
    //懒加载一个对象
    private lazy var recommendVM:JFRecommenViewModel =  JFRecommenViewModel()
    
    
    private lazy var cycleView:JFRecommendCycleView = {
        let  view =  JFRecommendCycleView.recommendCycleView()
        view.frame = CGRect(x: 0, y: -(KCycleViewH+KGameViewH), width: kScreenWidth, height: KCycleViewH)
        return view
    }()
    
    private lazy var gameView:JFRecommendGameView = {
           let  view =  JFRecommendGameView.recommendGameView()
           view.frame = CGRect(x: 0, y: -KGameViewH, width: kScreenWidth, height: KGameViewH)
           return view
       }()
    
    
    override func setupUI(){
        //先调用super.setupUI
        super.setupUI()
           collectionView.addSubview(cycleView)
           collectionView.addSubview(gameView)
           //增加内边距 来使 添加在collectionView的view显示
           collectionView.contentInset = UIEdgeInsets(top: KCycleViewH + KGameViewH, left: 0, bottom: 0, right: 0)
       }
    
    override func loadData(){
        //给父类的viewModel进行赋值
        //父类中的 viewModel 是没有值的 
        baseVM = recommendVM
        
        //这里不会循环引用
        //闭包对控制器强引用 控制器对对象强引用， 但是对象没有对闭包强引用
        // [weak self] in用不用都行
        recommendVM.requestData {
            self.collectionView.reloadData()
           var groups = self.recommendVM.anchorGroups
           groups.remove(at: 0)
           groups.remove(at: 0)
           let group = AnchorGroup()
           group.tag_name = "更多"
           groups.append(group)
          self.gameView.groups = groups
        }
        
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
         if indexPath.section == 1 {
             return CGSize(width: kItemW, height: kPrettyItemH)
         }
         return CGSize(width: kItemW, height: kNormalItemH)
     }
    

}


//extension RecommendViewController :  {
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        //~~~2、只有section == 1的参数的cell是不同的，所以子类专门区分出来，然后进行布局和显示。
//        if indexPath.section == 1 {
//            // 1.取出PrettyCell
//            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
//
//            // 2.设置数据
//            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
//
//            return prettyCell
//        } else {
//            // 3、其余的和父类相同，我们直接使用父类的方法super，来显示数据。  由于index.section==1的cell比较特殊，且只有在Recommend界面才有这个cell,所以我们再子类中加载其数据，其余的section我们加载到父类中。
//            //提取父类的意义：公共的方法和内容的加载我们都放到父类中，不同页面不同的界面展示，我们再在子类的上面添加相应的UI以及数据的处理，然后再调用父类的方法。
//            print("打印的传给父类的索引为\(indexPath.section)")
//            return super.collectionView(collectionView, cellForItemAt: indexPath)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 1 {
//            return CGSize(width: kItemW, height: kPrettyItemH)
//        }
//
//        return CGSize(width: kItemW, height: kNormalItemH)
//    }
//}


