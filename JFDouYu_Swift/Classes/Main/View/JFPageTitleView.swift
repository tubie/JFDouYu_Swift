//
//  JFPageTitleView.swift
//  JFDouYu_Swift
//
//  Created by lin jianfang on 2020/8/23.
//  Copyright © 2020 lin jianfang. All rights reserved.
//

import UIKit

private let KScrollLineH:CGFloat = 2

class JFPageTitleView: UIView {
    
    private var titles:[String]

    //懒加载一个数组
    private lazy var titleLabels:[UILabel] = [UILabel]()
    
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
