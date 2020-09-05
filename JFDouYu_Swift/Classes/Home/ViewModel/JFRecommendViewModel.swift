//
//  JFHomeViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/1.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFRecommenViewModel {
    //懒加载数组的属性 用来存放模型数据
    //供其他类调用 要去掉private
     lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()//创建数组
    
    //循环的 model
    lazy var cycleModels:[JFCycleModel] = [JFCycleModel]()//

  
    //颜值
    private lazy var prettyGroups:AnchorGroup = AnchorGroup()
    
    //热门
    private lazy var hotGroups:AnchorGroup = AnchorGroup()


}

//发送网络请求
extension JFRecommenViewModel{
//    @escaping()->()逃逸闭包修饰符
    func requestData(finishCallBack:@escaping()->()){
        let  parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]

        //请求推荐数据
        let dispatch = DispatchGroup()
        dispatch.enter()
        JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getCurrentTime()] as  [String : NSString]) { (result) in
            
            guard let result = result as?[String:NSObject] else { return }
            
            // as? [String:NSObject] 转成数组 并且数组是字典类型
            guard let dataArray = result["data"] as? [[String:NSObject]] else { return}
            
            
            self.hotGroups.tag_name =  "热门"
            self.hotGroups.icon_name = "home_header_hot"
              for dict in dataArray{
                  let anchor = AnchorModel(dict: dict)
                self.hotGroups.anchors.append(anchor)
              }
            dispatch.leave()
            
               }
        
        
        //请求颜值数据
        dispatch.enter()
        JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : NSString]) { (result) in
            guard let result = result as?[String:NSObject] else{ return}
            
            // as? [String:NSObject] 转成数组 并且数组是字典类型
            guard let dataArray = result["data"] as? [[String:NSObject]] else { return}
            
            self.prettyGroups.tag_name =  "颜值"
            self.prettyGroups.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroups.anchors.append(anchor)
            }
            dispatch.leave()

            
        }
        
        
        //请求游戏数据
        dispatch.enter()
        JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters  as [String : NSString]) { (result) in
            
            //字典转模型
            guard let resultDict = result as? [String:NSObject]  else { return }
            
            // as? [String:NSObject] 转成数组 并且数组是字典类型
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else { return}
            
            //遍历数组  获取字典并且转成模型对象
            for group in dataArray{
                let anchor = AnchorGroup(dict: group)
                self.anchorGroups.append(anchor)
            }
            dispatch.leave()
        }
        
        dispatch.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroups, at: 0)
            self.anchorGroups.insert(self.hotGroups, at: 0)
            finishCallBack()
        }
        
    }
    
    
    func requestCycleData(finishCallBack:@escaping()->()){
        
        JFNetworkTool.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"] as  [String : NSString]) { (result) in
                   
               guard let result = result as?[String:NSObject] else { return }
               
               // as? [String:NSObject] 转成数组 并且数组是字典类型
               guard let dataArray = result["data"] as? [[String:NSObject]] else { return}
            
            for dict in dataArray{
                self.cycleModels.append(JFCycleModel(dict: dict))
            }
            finishCallBack()
        }
                   
                   
        
    }
    
}
