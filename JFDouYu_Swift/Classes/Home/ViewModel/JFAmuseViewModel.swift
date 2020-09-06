//
//  JFAmuseViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFAmuseViewModel: NSObject {
    
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()

}

extension JFAmuseViewModel{
         func requestAmuseData( finishCallBack:@escaping ()->()){
    //        let parameters = ["shortName" : "game"]
            JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (response) in
                
                guard let response = response as? [String:Any] else { return }
                         
                // as? [String:NSObject] 转成数组 并且数组是字典类型
                guard let dataArray = response["data"] as? [[String:Any]] else { return}
                
                for dict in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
                finishCallBack()
            }
        }
}
