//
//  JFGameViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

/// 可以不继承 : NSObject 使这个 JFGameViewModel 更轻量级
class JFGameViewModel{
    //懒加载 定义一个模型数组 用来保存数据 给控制器 或者外部使用
    lazy var gameModels:[JFGameModel] = [JFGameModel]()
}

extension JFGameViewModel{
     func requestGameData( finishCallBack:@escaping ()->()){
        let parameters = ["shortName" : "game"]
        JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters:parameters as [String : NSString]) { (response) in
            
            guard let response = response as? [String:Any] else { return }
                     
            // as? [String:NSObject] 转成数组 并且数组是字典类型
            guard let dataArray = response["data"] as? [[String:Any]] else { return}
            
            for dict in dataArray{
                self.gameModels.append(JFGameModel(dict: dict))
            }
            finishCallBack()
        }
    }
}
