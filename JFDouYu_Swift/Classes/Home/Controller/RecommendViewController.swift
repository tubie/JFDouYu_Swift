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

private let KPrettyCellID = "KPrettyCellID"


class RecommendViewController: BaseAnchorViewController {
    
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
            
            //数据请求完成
            self.loadDataFinished()
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let  cell =  collectionView.dequeueReusableCell(withReuseIdentifier: KPrettyCellID, for: indexPath) as! JFCollectionViewPrettyCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
}



