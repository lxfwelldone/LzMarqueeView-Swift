//
//  LzMarqueeView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit


protocol LzMarqueeViewProtocol : class {
    func clickOnCurrentModel(marquee : LzMarqueeView, model : Person)
}

class LzMarqueeView: UIView {

    /*
    * 这是一个内容由上而下无限滚动的view
    */
    var datas : [Person] = [Person]()
    var isShowFirst : Bool = true
    var dataIndex : Int = 0
    var timer : Timer? = nil
    var timerCount : TimeInterval = 3
    var duration : TimeInterval = 3
    weak var delegate : LzMarqueeViewProtocol? = nil
    
    private lazy var itemFirst : LzMarqueeItem = {
        let itemFirst = LzMarqueeItem(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        itemFirst.backgroundColor = UIColor.blue
        itemFirst.delegate = self
        return itemFirst
    }()

    private lazy var itemSecond : LzMarqueeItem = { 
        let itemSecond = LzMarqueeItem(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height))
        itemSecond.backgroundColor = UIColor.red
        itemSecond.delegate = self
        return itemSecond
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LzMarqueeView : LzMarqueeItemProtocol{
    func lzMarqueeItemClicked(item: LzMarqueeItem, model: Person) {
        delegate?.clickOnCurrentModel(marquee: self, model: model)
    }
}

extension LzMarqueeView {
    func setUI(){
        self.clipsToBounds = true
    }
    
    func reloadData(datas : [Person]) {
        endTimer()
        if self.datas.count > 0 {
            self.datas.removeAll()
        }
        for p in datas {
            self.datas.append(p)
        }
        if self.datas.count > 0 {
            addSubview(itemFirst)
            itemFirst.displayModel(model: self.datas[0])
            if self.datas.count >= 2 {
                addSubview(itemSecond)
                startTimer()
            }
        }else {
            self.frame = CGRect.zero
        }
    }
    
    /**
     开始计时器
    */
    func startTimer(){
        if timer==nil {
            timer = Timer.init(timeInterval: 2, target: self, selector:#selector(LzMarqueeView.scrollFromBottomToTop), userInfo: nil, repeats: true);
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
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

        let viewToTop : LzMarqueeItem
        let viewFromBottm : LzMarqueeItem
        if isShowFirst {
            viewFromBottm = itemSecond
            viewToTop = itemFirst
        } else {
            viewToTop = itemSecond
            viewFromBottm = itemFirst
        }
        isShowFirst = !isShowFirst
        viewFromBottm.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height)
        
        if dataIndex >= datas.count-1 {
            dataIndex = 0
        } else {
            dataIndex += 1
        }
        viewFromBottm.displayModel(model: datas[dataIndex])
    
        UIView.animate(withDuration: duration) {
            viewFromBottm.frame = CGRect(x: 0, y: 0, width: viewFromBottm.frame.size.width, height: viewFromBottm.frame.size.height)
            viewToTop.frame = CGRect(x: 0, y: -viewToTop.frame.size.height, width: viewToTop.frame.size.width, height: viewToTop.frame.size.height)
        }

    }
}

