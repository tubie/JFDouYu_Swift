//
//  JFFunnyViewModel.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class JFFunnyViewModel : BaseViewModel {

}

extension JFFunnyViewModel{
    func loadFunnyData(finishedCallBack: @escaping ()->()){
        loadAnchorData(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
