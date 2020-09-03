//
//  NSDate-Extention.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import Foundation

extension NSDate{
     class func getCurrentTime() -> String {
        let interval =  NSDate().timeIntervalSince1970
        return "\(interval)"
    }
}
