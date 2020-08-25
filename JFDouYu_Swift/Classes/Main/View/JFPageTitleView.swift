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
        scrollLine.backgroundColor = UIColor.orange
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
            label.textColor = UIColor.darkGray
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
        bottomLine.backgroundColor = UIColor.darkGray
        bottomLine.frame = CGRect(x: 0, y:frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
//        titleLabels.first 是可选类型 用 guard进行判断
        guard let firstlabel  = titleLabels.first  else { return}
        firstlabel.textColor = UIColor.orange
        
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
        
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
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
