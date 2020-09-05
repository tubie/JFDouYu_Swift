//
//  JFRecommendCycleView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/5.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let KCycleCellID = "KCycleCellID"



class JFRecommendCycleView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControllerView: UIPageControl!
    
    var cycleTime:Timer?
    
        
    var cycleModels : [JFCycleModel]?{
        didSet{
            guard let cycleModels = cycleModels  else {return}
            pageControllerView.numberOfPages = cycleModels.count
            collectionView.reloadData()
            
            //默认滚到摸一个位置
            let indexPath = NSIndexPath(item: cycleModels.count * 10 , section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:KCycleCellID)
        collectionView.register(UINib(nibName: "JFCollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: KCycleCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        removeTimer()
        addTimer()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = collectionView.bounds.size
    }


}

//快速创建 创建view
extension JFRecommendCycleView{
    class func recommendCycleView() -> JFRecommendCycleView{
        return Bundle.main.loadNibNamed("JFRecommendCycleView", owner: nil, options: nil)?.first as! JFRecommendCycleView;
    }
}

extension JFRecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cycleModels这里这个肯定有值
        //(cycleModels?.count ?? 0) * 10000 添加10000行 不会有性能问题 cell循环引用
        // % cycleModels!.count 防止越界 10000 % 3 = 1
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCycleCellID, for: indexPath) as! JFCollectionViewCycleCell
        cell.cycleModel = cycleModel
        return cell
    }
}
extension JFRecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //计算偏移量 +  scrollView.bounds.size.width * 0.5 拖到一半就 开始显示下一1
        let offSetX = scrollView.contentOffset.x +  scrollView.bounds.width * 0.5
        //计算currentIndex
         // % (cycleModels?.count ??  1  0不能对0 取模
        let currentIndex:Int =  Int(offSetX / kScreenWidth) % (cycleModels?.count ?? 1)
    
        pageControllerView.currentPage = currentIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

//对定时器的操作防范
extension JFRecommendCycleView{
    func addTimer() {
        cycleTime = Timer(timeInterval: 3, repeats: true, block: { (time) in
            //获取滚动的偏移量
            //当前的偏移量
            let currentoffsetX = self.collectionView.contentOffset.x
            
            //滚动一页的偏移量
            let offsetX = currentoffsetX + self.collectionView.bounds.width
            
            //滚动到该位置
            self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            
            
        })
        RunLoop.main.add(self.cycleTime!, forMode: .common)
    }
    
    func removeTimer(){
        cycleTime?.invalidate()
        cycleTime = nil
    }
}
