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
    
    //逃逸闭包 @escaping 闭包在另外一个闭包中使用需要  @escaping修饰
    //result:AnyObject 改成any 则callBack(result as AnyObject) 改成            callBack(result)
    /*
     parameters: parameters,
      encoding: URLEncoding.default,
      headers: nil).responseJSON { (response) in
     有默认参数 可以直接去掉
     */
    
    

    
    class func requestData(type:MethodType , urlString:String,parameters:[String:NSString]? = nil, callBack:@escaping (_ result:Any)->())  {
        
        //获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
      
        Alamofire.request(urlString,
                          method:method ,
                          parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value  else{
                print(response.result.error as Any)
                return}
            callBack(result)
        }
        
    }

}
