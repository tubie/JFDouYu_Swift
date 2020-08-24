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
    private lazy var pageTitleView:JFPageTitleView = {
        let frame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight, width: kScreenWidth, height: KtitleViewH)
        let titles  = ["推荐","游戏","娱乐","趣玩"]
        let titleView = JFPageTitleView(frame: frame, titles: titles)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.addSubview(pageTitleView)
        // Do any additional setup after loading the view.
    }
}

extension JFHomeViewController{
    private func setupUI(){
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
