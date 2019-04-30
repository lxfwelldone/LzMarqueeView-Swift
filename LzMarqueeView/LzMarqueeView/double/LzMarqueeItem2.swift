//
//  LzMarqueeItem2.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/29.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol LzMarqueeItem2Protocol : class {
    func lzMarqueeItem2ProtocolClickedModel(model : Person)
}

class LzMarqueeItem2: UIView {

    weak var delegate : LzMarqueeItem2Protocol? = nil
    
    private lazy var itemOne : LzMarqueeItem = {
        let itemOne = LzMarqueeItem.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height/2))
        itemOne.delegate = self
        return itemOne
    }()
    
    private lazy var itemTwo : LzMarqueeItem = {
        let itemTwo = LzMarqueeItem.init(frame: CGRect(x: 0, y: self.frame.size.height/2, width: self.frame.size.width, height: self.frame.size.height/2))
        itemTwo.delegate = self
        return itemTwo
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.isUserInteractionEnabled = true
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
        itemOne.displayModel(model: model1)
        itemTwo.displayModel(model: model2)
    }
}

extension LzMarqueeItem2 : LzMarqueeItemProtocol{
    func lzMarqueeItemClicked(model: Person) {
        delegate?.lzMarqueeItem2ProtocolClickedModel(model: model)
    }
}
