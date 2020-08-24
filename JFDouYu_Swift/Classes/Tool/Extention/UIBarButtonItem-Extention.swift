//
//  UIBarButtonItem-Extention.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/21.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    
    /*
     不建议这么写
     class func createItem(imageName: String, higtImageName:String ,size:CGSize) -> UIBarButtonItem{
            let btn  = UIButton()
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: higtImageName), for: .highlighted)
            btn.frame = CGRect(origin: .zero, size:size)
            return UIBarButtonItem(customView: btn)
        }
     */
    
    
    
    
    /*
     swift 建议构造函数
     1、构造函数不需要写返回值
     2、在extension 只能扩充便利构造函数 convenience 加上开头便利构造函数
     3、必须 明确调用一个设计的构造函数（self）
     
     */
    
    /*
     默认字符串
     higtImageName:String = ""
     
     */
    
    convenience init(imageName: String, higtImageName:String = "" ,size:CGSize = .zero) {
        let btn  = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if higtImageName != "" {
            btn.setImage(UIImage(named: higtImageName), for: .highlighted)
        }
        if size == .zero {
            //按钮大小自适应
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: .zero, size:size)
        }
        
        self.init(customView:btn)
    }
    
   
}
