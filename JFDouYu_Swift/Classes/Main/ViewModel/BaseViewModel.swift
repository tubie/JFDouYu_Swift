//
//  BaseViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit


/// 抽取父类的思想 抽取属性 或者方法较少的那个类
class BaseViewModel {
     //供其他类调用 要去掉private
     lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()//创建数组
}

extension BaseViewModel{
    func loadAnchorData(urlString : String, parameters : [String : Any]? = nil, finishedCallBack: @escaping ()->()) {
        
        JFNetworkTool.requestData(type: .GET, urlString: urlString , parameters: parameters as? [String : NSString] ) { (response) in
               
               guard let response = response as? [String:Any] else { return }
                        
               // as? [String:NSObject] 转成数组 并且数组是字典类型
               guard let dataArray = response["data"] as? [[String:Any]] else { return}
               
               for dict in dataArray{
                   self.anchorGroups.append(AnchorGroup(dict: dict))
               }
               finishedCallBack()
           }
    }
}
