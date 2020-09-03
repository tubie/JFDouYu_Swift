//
//  JFHomeViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/1.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFRecommenViewModel {

}

//发送网络请求
extension JFRecommenViewModel{
    func requestData(){
        
        let  parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        JFNetworkTool.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters as [String : NSString]) { (result) in
            print(result)
            
            //
        }
        
    }
    
}
