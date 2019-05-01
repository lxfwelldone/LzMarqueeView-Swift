//
//  LzMarqueeItem2.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/29.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol LzMarqueeItem2Delegate : class {
    func clickOnItem2View(itemView : LzMarqueeItem2, model : Person)
}

class LzMarqueeItem2: UIView {

    weak var delegate : LzMarqueeItem2Delegate? = nil
    
    private lazy var itemOne : LzMarqueeItem = { [weak self] in
        let itemOne = LzMarqueeItem.init(frame: CGRect(x: 0, y: 0, width: self!.frame.size.width, height: self!.frame.size.height/2))
        itemOne.delegate = self
        return itemOne
    }()
    
    private lazy var itemTwo : LzMarqueeItem = { [weak self] in
        let itemTwo = LzMarqueeItem.init(frame: CGRect(x: 0, y: self!.frame.size.height/2, width: self!.frame.size.width, height: self!.frame.size.height/2))
        itemTwo.delegate = self
        return itemTwo
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.isUserInteractionEnabled = true
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LzMarqueeItem2 {
    func setUI() {
        addSubview(itemOne)
        addSubview(itemTwo)
    }
    
    func displayTwoDatas(model1 : Person, model2 : Person) {
        itemOne.displayModel(model1)
        itemTwo.displayModel(model2)
    }
}

extension LzMarqueeItem2 : LzMarqueeItemDelegate{
    func clickOnMarqueeItem(itemView: LzMarqueeItem, model: Person) {
        delegate?.clickOnItem2View(itemView: self, model: model)
    }
}
