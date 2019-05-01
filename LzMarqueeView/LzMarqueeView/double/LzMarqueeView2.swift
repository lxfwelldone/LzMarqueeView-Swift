//
//  LzMarqueeItemView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/25.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol LzMarqueeView2Delegate : class {
    func clickOnMarqueeView2(view : LzMarqueeView2, model : Person)
}


class LzMarqueeView2 : UIView {

    weak var delegate : LzMarqueeView2Delegate? = nil
    var datas : [Person] = [Person]()
    var dataIndex : Int = 0
    var isShowFirst : Bool = true
    var timer : Timer? = nil
    
    private lazy var itemFirst : LzMarqueeItem2 = {
        let first = LzMarqueeItem2.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        first.delegate = self
        first.backgroundColor = UIColor.red
        return first
    }()
    
    private lazy var itemSecond : LzMarqueeItem2 = {
        let second = LzMarqueeItem2.init(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height))
        second.delegate = self
        second.backgroundColor = UIColor.green
        return second
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LzMarqueeView2 {
    func reloadData(data : [Person]){
        datas.removeAll()
        for obj in data {
            datas.append(obj)
        }
        
        if datas.count > 0 {
            addSubview(itemFirst)
            configModels()
            
            if datas.count > 2 {
                addSubview(itemSecond)
                startTimer()
            }
        }
    }
    
    func configModels(){
        let model1 : Person
        let model2 : Person
        model1 = datas[dataIndex]
        if dataIndex < datas.count-2 {
            model2 = datas[dataIndex + 1]
        }
//        if isShowFirst {
//            itemFirst.displayTwoDatas(model1: model1, model2: model2)
//        } else {
//            itemSecond.displayTwoDatas(model1: model1, model2: model2)
//        }
    }
    
    @objc func scrollFromBottomToTop(){
        var viewToTop : LzMarqueeItem2
        var viewFromBottm : LzMarqueeItem2
        if isShowFirst {
            viewFromBottm = itemSecond
            viewToTop = itemFirst
        } else {
            viewFromBottm = itemFirst
            viewToTop = itemSecond
        }
        isShowFirst = !isShowFirst
        viewFromBottm.frame = CGRect(x: 0, y: self.frame.size.height, width: viewFromBottm.frame.size.width, height: viewFromBottm.frame.size.height)
        
        UIView.animate(withDuration: 3) {
            viewFromBottm.frame = CGRect(x: 0, y: 0, width: viewFromBottm.frame.size.width, height: viewFromBottm.frame.size.height)
            viewToTop.frame = CGRect(x: 0, y: -self.frame.size.height, width: viewToTop.frame.size.width, height: viewToTop.frame.size.height)
        }

        //  这里是处理数据源取出的逻辑。（重点）
        //    由于加2可能会大于count所以使用>=而不是==，防止count为奇数时崩溃
        if (dataIndex >= datas.count-2) {
            dataIndex = 0
        } else {
            dataIndex += 2
        }
        configModels()
    }
    
    func startTimer(){
        if timer == nil {
            timer = Timer.init(timeInterval: 3, target: self, selector: #selector(LzMarqueeView2.scrollFromBottomToTop), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        }
        timer?.fire()
    }
    
    func endTimer(){
        if timer == nil {
            return
        }
        timer?.invalidate()
        timer = nil
    }
}

extension LzMarqueeView2 : LzMarqueeItem2Delegate {

    func clickOnItem2View(itemView: LzMarqueeItem2, model: Person) {
        
    }
}
