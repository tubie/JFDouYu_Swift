//
//  JFHomeViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/21.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private  let KtitleViewH:CGFloat = 40

class JFHomeViewController: UIViewController {
    
    //懒加载
    private lazy var pageTitleView:JFPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: KtitleViewH)
        let titles  = ["推荐","游戏","娱乐","趣玩"]
        let titleView:JFPageTitleView = JFPageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView:JFPageContentView = { [weak self ] in
        let contentViewFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + KtitleViewH, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight - kNavigationBarHeight - KtitleViewH)
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1.0)
            childVcs.append(vc)
        }
        let  contentView = JFPageContentView(frame: contentViewFrame, childVcs:childVcs, parentViewController: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

extension JFHomeViewController{
    private func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", higtImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", higtImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", higtImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]

    }
}

//遵守协议
extension JFHomeViewController:JFPageTitleViewDelegate{
    func JFPageTitleViewSelectAtIndex(titleView: JFPageTitleView, selectIndex: Int) {
        print(selectIndex)
    }
}
