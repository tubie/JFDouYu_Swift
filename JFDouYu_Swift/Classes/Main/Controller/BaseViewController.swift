//
//  BaseViewController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView:UIView?
    
    
    fileprivate lazy var imageView:UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        //数组中不能试可选类型
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration  = 0.5
        //LONG_MAX 非常大的整形
        imageView.animationRepeatCount = LONG_MAX
        
        //顶部和底部随父控件的 拉伸而拉伸
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor.white
        contentView?.isHidden = true
        view.addSubview(imageView)
        imageView.startAnimating()
    }
    
    func loadDataFinished(){
        imageView.stopAnimating()
        imageView.isHidden = true
        contentView?.isHidden = false
        
    }
}
