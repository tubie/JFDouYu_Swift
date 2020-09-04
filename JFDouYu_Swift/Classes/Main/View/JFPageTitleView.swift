//
//  JFPageTitleView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/23.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

//标明只能被类遵守  （如果不写也可以被 结构体，枚举遵守 不建议）这样不能把代理属性定义为可选类型
//定义一个协议
protocol JFPageTitleViewDelegate : class {
    //声明一个协议的方法
    func JFPageTitleViewSelectAtIndex(titleView:JFPageTitleView,selectIndex index:Int)
}

private let KScrollLineH:CGFloat = 2
//定义元组常量
private let KNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let KSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)


class JFPageTitleView: UIView {
    
    private var titles:[String]
    //懒加载一个数组
    private lazy var titleLabels:[UILabel] = [UILabel]()
    private var currentIndex:Int = 0
    //声明一个代理的属性
    weak var delegate:JFPageTitleViewDelegate?
     
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2, a: 1)
        return scrollLine
    }()
    
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JFPageTitleView{
    private func setupUI(){
        scrollView.frame = bounds        
        
        addSubview(scrollView)
        
        setupTitleLabel()
        
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabel(){
        //swift没有隐式转化的  一个是CGFloat 类型 一个是 int类型不能直接 乘除
         let labelW:CGFloat = frame.width / CGFloat(titles.count)
         let labelH:CGFloat = frame.height - KScrollLineH
         let labelY:CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2, a: 1)
            label.textAlignment = .center
            let labelX:CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        let lineH:CGFloat = 0.5
        bottomLine.backgroundColor = UIColor(r: 234, g: 234, b: 234, a: 1)
        bottomLine.frame = CGRect(x: 0, y:frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
//        titleLabels.first 是可选类型 用 guard进行判断
        guard let firstlabel  = titleLabels.first  else { return}
        firstlabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2, a: 1)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstlabel.frame.origin.x, y: frame.height - KScrollLineH, width:firstlabel.frame.width, height: KScrollLineH)
    }
    
}

extension JFPageTitleView {
    // label点击
    @objc private func labelClick(tapGes:UITapGestureRecognizer){
        //当前的label
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        if currentLabel.tag == currentIndex {return}

        //old label
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2, a: 1)
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2, a: 1)
        
        //保存最新label的下标值
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        //代理必须是可选的 因为外部可以不遵守这个代理 所以是weak 修饰， "?"
        delegate?.JFPageTitleViewSelectAtIndex(titleView: self, selectIndex: currentIndex)
                
    }
}

//对外暴露方法
extension JFPageTitleView{
    func setTitleViewWithProgress(progress:CGFloat,sourceIndex:Int,targartIndex:Int){
        
        //取出label
        let sourceLabel = titleLabels[sourceIndex]
        let targartLabel = titleLabels[targartIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targartLabel.frame.origin.x -  sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的渐变
        //取出变化范围
        let colorDelta =  (KSelectColor.0 - KNormalColor.0,
                           KSelectColor.1 - KNormalColor.1,
                           KSelectColor.2 - KNormalColor.2)
        
        
        //sourceLabel 是右 高亮边灰色 色值有大变小的过程
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress,
                                        g: KSelectColor.1 - colorDelta.1 * progress,
                                        b: KSelectColor.2 - colorDelta.2 * progress,
                                        a: 1)
        
        //targartLabel 是右 高亮边灰色 色值有小变大的的过程
        targartLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress,
        g: KNormalColor.1 + colorDelta.1 * progress,
        b: KNormalColor.2 + colorDelta.2 * progress,
        a: 1)
        
        //记录currentIndex
        currentIndex = targartIndex
        
        
    }
}
