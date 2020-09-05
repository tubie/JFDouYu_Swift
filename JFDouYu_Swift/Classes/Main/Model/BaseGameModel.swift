//
//  BaseGameModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit


/// 子类可以继承父类的所有属性和方法 可以用来抽取 公共的属性和方法
class BaseGameModel: NSObject {
    
    //定义属性  swift 4.0 之后需要手动添加@objc 否则转模型会没有值
        @objc var tag_name : String = ""
        @objc var icon_url : String = ""

        init(dict:[String:Any]) {
           super.init()
           setValuesForKeys(dict)
        }
        //构造函数 在调用的时候 才可以用 AnchorGroup()来创建
        override init() {}

        override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
