//
//  AnchorGroup.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //room_list 是个数组里面存放着 dict
     @objc var room_list:[[String:NSObject]]?{
        //通过属性的监听来 判断是否有值 且 进行dict 转模型
        didSet{
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
            
        }
    }
    //定义属性  swift 4.0 之后需要手动添加@objc 否则转模型会没有值
    @objc var small_icon_url : String = ""
    @objc var icon_name : String = "home_header_hot" //默认赋值一个图标
    //定义主播模型对象的数组
    @objc lazy var anchors:[AnchorModel] = [AnchorModel]()
    
 
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String:NSObject]]{
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//        }
//    }

    
    
    

}
