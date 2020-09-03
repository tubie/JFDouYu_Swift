//
//  JFNetworkTool.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/4.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class JFNetworkTool{
    
    //字典类型 [String:NSString]
    //parameters:[String:NSString]? = nil, 默认参数 方便外面调用
    //callBack:()->() 闭包的写法 第一个（）里面添加参数
    
    //逃逸闭包 @escaping
    
    class func requestData(type:MethodType , urlString:String,parameters:[String:NSString]? = nil, callBack:@escaping (_ result:AnyObject)->())  {
        
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
      
        Alamofire.request(urlString,
                          method:method ,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
            guard let result = response.result.value  else{
                print(response.result.error as Any)
                return}
            callBack(result as AnyObject)
        }
        
    }

}
