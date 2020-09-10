//
//  BaseNavigationController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //拦截跳转之前先隐藏 底部的导航栏
        viewController.hidesBottomBarWhenPushed = true
        
        //调用父类
        super.pushViewController(viewController, animated: true)
    }

}
