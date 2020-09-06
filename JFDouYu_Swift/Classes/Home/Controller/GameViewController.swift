//
//  GameViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 2 ) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let KGameCellID = "KGameCellID"
private let KHeaderViewH:CGFloat = 50
private let KHeaderViewID = "KHeaderViewID"
private let KGameViewH:CGFloat = 90

class GameViewController: UIViewController {
    
    fileprivate lazy var gameViewModel:JFGameViewModel =  JFGameViewModel()
    
    fileprivate lazy var collectionView:UICollectionView = {
            let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemW, height: kItemH)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            //设置组头
            layout.headerReferenceSize = CGSize(width: kScreenWidth, height: KHeaderViewH)
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
            
            let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
                  //经常使用 高度随着父控件的拉伸而拉伸。
                  collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            
            collectionView.register(UINib(nibName: "JFCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
        
         //nib 注册
               collectionView.register(UINib(nibName: "JFCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID)
            
            collectionView.dataSource = self
//            collectionView.delegate = self
          
            return collectionView
        }()
    
    fileprivate lazy var topHeaderView:JFCollectionHeaderView = {
        let topView = JFCollectionHeaderView.collectionHeaderView()
        topView.frame = CGRect(x: 0, y: -(KHeaderViewH + KGameViewH), width: kScreenWidth, height: KHeaderViewH)
        topView.titleLabel.text = "常用"
        topView.iconImageView.image = UIImage(named: "Img_orange")
        topView.moreBtn.isHidden = true
        return topView
    }()
    
    fileprivate lazy var gameView:JFRecommendGameView = {
        let gameView = JFRecommendGameView.rmGameView()
        gameView.frame = CGRect(x: 0, y: -KGameViewH, width: kScreenWidth, height: KGameViewH)
        return gameView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        requestData()
        
    }
}

extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: KHeaderViewH + KGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}

extension GameViewController{
    fileprivate func requestData(){
        gameViewModel.requestGameData {
            //全部游戏
            self.collectionView.reloadData()
            
            //部分游戏
            // var  tmpArray:[BaseGameModel] = [BaseGameModel]()创建一个数组
            
            /* 不建议这么取
             var  tmpArray:[BaseGameModel] = [BaseGameModel]()
                       for i in 0..<10{
                           tmpArray.append(self.gameViewModel.gameModels[i])
                       }
             */
          
//            let tmp = self.gameViewModel.gameModels[0..<10]
            // 类型ArraySlice 通过 Array来转化
            self.gameView.groups = Array(self.gameViewModel.gameModels[0..<10])
        }
    }
}

extension GameViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath) as! JFCollectionGameCell
        let gameModel = gameViewModel.gameModels[indexPath.item]
        // cell.group = gameModel
        // Cannot assign value of type 'JFGameModel' to type 'AnchorGroup' 模型不匹配

        cell.baseGame = gameModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: KHeaderViewID, for: indexPath) as! JFCollectionHeaderView
//               let group = recommendVM.anchorGroups[indexPath.section]
//               headerView.anchorGroup = group
        
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
               
               return headerView
        
    }
}
