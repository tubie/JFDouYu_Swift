//
//  BaseNavigationController.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/9/10.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //获取手势添加的view
        
        guard let gesView = systemGes.view else { return }
        
        var count:UInt32 = 0
        //获取类的所有属性 UnsafeMutablePointer
        //count 需要传入一个指针 及取下地址
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            //获取属性名
            let name = ivar_getName(ivar)
//            print(String(cString:name!))
        }
        //KVC获取_targets
        /*
         Optional(<__NSArrayM 0x600001efe0d0>(
         (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7f82f9713fb0>)
         )
         )
         */
        
        //as? [NSObject] 强转 数组
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        //可选类型要抓 guard 校验
        guard let targetObjc =  targets?.first else { return }
        //取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        //取出action
        //取不出来
//        guard let action = targetObjc.value(forKey: "action") as? Selector else { return }
//        print(action)
        
        //通过打印可看出出来 action=handleNavigationTransition
        let action = Selector(("handleNavigationTransition:"))
        
        //创建自己的手势
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action )

        gesView.addGestureRecognizer(panGes)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //拦截跳转之前先隐藏 底部的导航栏
        viewController.hidesBottomBarWhenPushed = true
        
        //调用父类
        super.pushViewController(viewController, animated: true)
    }

}

/*
 
 /*
 
 _gestureFlags
 _targets
 _delayedTouches
 _delayedPresses
 _view
 _lastTouchTimestamp
 _firstEventTimestamp
 _state
 _allowedTouchTypes
 _initialTouchType
 _internalActiveTouches
 _forceClassifier
 _requiredPreviewForceState
 _touchForceObservable
 _touchForceObservableAndClassifierObservation
 _forceTargets
 _forcePressCount
 _beganObservable
 _failureRequirements
 _failureDependents
 _activeEvents
 _inputPrecision
 _keepTouchesOnContinuation
 _delegate
 _allowedPressTypes
 _name
 _gestureEnvironment
 */
 */
