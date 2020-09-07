//
//  JFAmuseViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/6.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFAmuseViewModel: BaseViewModel {

}

extension JFAmuseViewModel{
    func requestAmuseData(finishCallBack : @escaping ()->()){
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishCallBack)
    }
}
