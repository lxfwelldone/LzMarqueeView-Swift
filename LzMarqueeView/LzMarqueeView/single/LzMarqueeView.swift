//
//  LzMarqueeView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit


protocol LzMarqueeViewDelegate : class {
    func clickOnMarqueeView(view : LzMarqueeView, model : Person)
}

class LzMarqueeView: UIView, LzMarqueeItemDelegate{

    /*
    * 这是一个内容由上而下无限滚动的view
    */

    var isShowFirst : Bool = true
    var dataIndex : Int = 0
    var timerCount : TimeInterval = 3
    var duration : TimeInterval = 3
    var timer : Timer? = nil

    var datas : [Person]? = nil
    weak var delegate : LzMarqueeViewDelegate? 

//    懒加载
//    lazy var itemFirst : LzMarqueeItem = { [weak self] in
//        let first = LzMarqueeItem(frame: CGRect(x: 0, y: 0, width: (self?.frame.size.width)!, height: (self?.frame.size.height)!))
//        first.delegate = self!
//        first.backgroundColor = UIColor.blue
//        return first
//    }()
//
//    lazy var itemSecond : LzMarqueeItem = { [weak self] in
//        let second = LzMarqueeItem(frame: CGRect(x: 0, y: (self?.frame.size.height)!, width: (self?.frame.size.width)!, height: (self?.frame.size.height)!))
//        second.delegate = self!
//        second.backgroundColor = UIColor.red
//        return second
//    }()
    
    var itemFirst : LzMarqueeItem?
    var itemSecond : LzMarqueeItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//   添加第一个
    func addItemFirst(){
        if self.itemFirst == nil {
            itemFirst = LzMarqueeItem.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            itemFirst?.delegate = self
            itemFirst?.backgroundColor = UIColor.red
            self.addSubview(itemFirst!)
        }
    }
//   添加第二个
    func addItemSecond(){
        if self.itemSecond == nil {
            itemSecond = LzMarqueeItem.init(frame: CGRect(x: 0, y: -self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height))
            itemSecond?.delegate = self
            itemSecond?.backgroundColor = UIColor.blue
            self.addSubview(itemSecond!)
        }
    }
    
//    遵守协议方法
    func clickOnMarqueeItem(itemView: LzMarqueeItem, model: Person) {
        if delegate != nil {
            print("代理方法：clickOnMarqueeItemView")
            delegate?.clickOnMarqueeView(view: self, model: model)
        }
    }
}

extension LzMarqueeView {

    /**
    * 外部调用方法传递数据源
    */
    func reloadData(datas : [Person]?) {
        endTimer()
        guard datas != nil else {
            return
        }

        self.datas = datas;
        if self.datas!.count > 0 {
            
//            addSubview(self.itemFirst)
            addItemFirst()
            itemFirst!.displayModel(self.datas![0])
            
            if self.datas!.count >= 2 {
//                addSubview(self.itemSecond)
                addItemSecond()
                startTimer()
                
//                LzGCDTimer.shareInstance.scheduledDispatchTimer(WithTimerName: "gcd", timeInterval: timerCount, queue: .main, repeats: true) {
//                    [weak self] in
//                    self!.scrollFromBottomToTop()
//                }
            }
        }else {
            self.frame = CGRect.zero
        }
    }
    
    /**
     开始计时器
    */
    func startTimer(){
        if timer == nil {
            timer = Timer.init(timeInterval: 2, target: self, selector:#selector(scrollFromBottomToTop), userInfo: nil, repeats: true);
            RunLoop.main.add(timer!, forMode: .tracking)
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
    
    /**
     计时执行的方法
    */
   @objc func scrollFromBottomToTop(){

        var viewToTop : LzMarqueeItem!
        var viewFromBottom : LzMarqueeItem!
        if isShowFirst {
            viewFromBottom = itemSecond
            viewToTop = itemFirst
        } else {
            viewToTop = itemSecond
            viewFromBottom = itemFirst
        }
        isShowFirst = !isShowFirst
        viewFromBottom.frame = CGRect(x: 0, y: viewFromBottom.frame.size.height, width: viewFromBottom.frame.size.width, height: viewFromBottom.frame.size.height)
        
        if dataIndex >= datas!.count-1 {
            dataIndex = 0
        } else {
            dataIndex += 1
        }
        viewFromBottom.displayModel(datas![dataIndex])
        UIView.animate(withDuration: 2) {
            viewFromBottom.frame = CGRect(x: 0, y: 0, width: viewFromBottom.frame.size.width, height: viewFromBottom.frame.size.height)
            viewToTop.frame = CGRect(x: 0, y: -viewToTop.frame.size.height, width: viewToTop.frame.size.width, height: viewToTop.frame.size.height)
        }

    }
}

