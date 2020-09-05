//
//  GameViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenWidth - kItemMargin * 2 )/3
private let KGameViewH:CGFloat = 90

private let KGameCellID = "KGameCellID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameViewModel:JFGameViewModel =  JFGameViewModel()
    
    fileprivate lazy var collectionView:UICollectionView = {
            let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: kItemW, height: KGameViewH)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = kItemMargin
            //设置组头
//            layout.headerReferenceSize = CGSize(width: kScreenWidth, height: KHeaderViewH)
            layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
            
            let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColor.white
                  //经常使用 高度随着父控件的拉伸而拉伸。
                  collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            
            collectionView.register(UINib(nibName: "JFCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: KGameCellID)
            
            collectionView.dataSource = self
//            collectionView.delegate = self
          
            return collectionView
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
    }
}

extension GameViewController{
    fileprivate func requestData(){
        gameViewModel.requestGameData {
            self.collectionView.reloadData()
        }
    }
}

extension GameViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGameCellID, for: indexPath)
        let gameModel = gameViewModel.gameModels[indexPath.item]
        print(gameModel.tag_name)
        cell.backgroundColor = indexPath.item % 3 == 0 ? UIColor.red : UIColor.purple
        return cell
        
    }
}
