//
//  RoomNormalViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

/*
 1、音视频的采集
 2、前处理
 3、编码 ->压缩减少体积大小
 4、传输
 5、流分发
 6、播放
 
 */

import UIKit

//UIGestureRecognizerDelegate 手势的代理

class RoomNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //隐藏掉导航栏 系统的机制 会把 手势返回禁掉 需要添加上来
        //已经做了全屏 pop就不需要再加这个了
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //显示导航栏航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
