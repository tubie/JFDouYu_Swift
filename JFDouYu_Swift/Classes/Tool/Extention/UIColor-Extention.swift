//
//  UIColor-Extention.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/25.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat ,a:CGFloat) {
        self.init(red : r/255.0, green:g/255.0, blue: b/255.0, alpha:1)
    }
}
