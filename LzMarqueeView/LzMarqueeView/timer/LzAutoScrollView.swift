//
//  LzAutoScrollView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/5/1.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol LzAutoScrollViewDelegate : class {
    func lzAutoScrollViewClicked(view : LzAutoScrollView, index : Int)
}

class LzAutoScrollView: UIView, LzViewDelegate {

    var isShowFirst : Bool = true
    private(set) var dataIndex : Int = 0
    var timerCount : TimeInterval = 3
    var duration : TimeInterval = 3
    var timer : Timer? = nil
    
    weak var delegate : LzAutoScrollViewDelegate?
    
    private lazy var itemFirst : LzView = { [weak self] in
        let itemFirst = LzView(frame: CGRect(x: 0, y: 0, width: self!.frame.size.width, height: self!.frame.size.height))
        itemFirst.backgroundColor = UIColor.red
        itemFirst.delegate = self
        return itemFirst
    }()
    
    private lazy var itemSecond : LzView = { [weak self] in
        let itemSecond = LzView(frame: CGRect(x: 0, y: self!.frame.size.height, width: self!.frame.size.width, height: self!.frame.size.height))
        itemSecond.backgroundColor = UIColor.green
        itemSecond.delegate = self
        return itemSecond
        }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
//        isUserInteractionEnabled = true
        addSubview(self.itemFirst)
        addSubview(self.itemSecond)
        startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("没有实现该方法")
    }

    func lzViewClicked() {
        delegate?.lzAutoScrollViewClicked(view: self, index: dataIndex)
    }
    
//  计时器方法
    @objc func timerAction(){
        var viewFromBottom : LzView
        var viewToTop : LzView
        if isShowFirst {
            viewFromBottom = itemSecond
            viewToTop = itemFirst
        } else {
            viewFromBottom = itemFirst
            viewToTop = itemSecond
        }
        isShowFirst = !isShowFirst
        viewFromBottom.frame = CGRect(x: 0, y: viewFromBottom.frame.size.height, width: viewFromBottom.frame.size.width, height: viewFromBottom.frame.size.height)
       
        UIView.animate(withDuration: duration) {
            viewFromBottom.frame = CGRect(x: 0, y: 0, width: viewFromBottom.frame.size.width, height: viewFromBottom.frame.size.height)
            viewToTop.frame = CGRect(x: 0, y: -viewToTop.frame.size.height, width: viewToTop.frame.size.width, height: viewToTop.frame.size.height)
        }
    }
    
    /**
     开始计时器
     */
    func startTimer(){
        if timer == nil {
            timer = Timer(timeInterval: timerCount, target: self, selector:#selector(timerAction), userInfo: nil, repeats: true);
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        }
        timer!.fire()
    }
    
    /**
     移除计时器
     */
    func endTimer(){
        if timer == nil {
            return
        }
        timer!.invalidate()
        timer = nil
    }
}
