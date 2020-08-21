//
//  JFHomeViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/21.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}

extension JFHomeViewController{
    private func setupUI(){
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", higtImageName: "", size: .zero)
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", higtImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", higtImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", higtImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]

    }
}
