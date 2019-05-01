//
//  TestView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/5/1.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol TestViewDelegate : class{
    func clickOnTestView(view : TestView, model : Person)
}

class TestView: UIView, LzMarqueeItemDelegate {

    weak var delegate : TestViewDelegate?
    let person : Person = Person(name: "bbbbb", age: 22)
    lazy var itemFirst : LzMarqueeItem = { [weak self] in
        let first = LzMarqueeItem(frame: CGRect(x: 0, y: 0, width: (self?.frame.size.width)!, height: (self?.frame.size.height)!/2))
        first.delegate = self!
        first.backgroundColor = UIColor.blue
        return first
        }()
    
    lazy var itemSecond : LzMarqueeItem = { [weak self] in
        let second = LzMarqueeItem(frame: CGRect(x: 0, y: (self?.frame.size.height)!/2, width: (self?.frame.size.width)!, height: (self?.frame.size.height)!/2))
        second.delegate = self!
        second.backgroundColor = UIColor.red
        return second
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.itemFirst)
        addSubview(self.itemSecond)
        itemFirst.displayModel(self.person)
        itemSecond.displayModel(self.person)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickOnMarqueeItemView(itemView: LzMarqueeItem, model: Person) {
        delegate?.clickOnTestView(view: self, model: model)
    }
}
