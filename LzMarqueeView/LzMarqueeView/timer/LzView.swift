//
//  LzView.swift
//  LzMarqueeView
//
//  Created by mc on 2019/5/1.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit

protocol LzViewDelegate : class {
    func lzViewClicked()
}

class LzView: UIView {

    weak var delegate : LzViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        addTapGesture()
    }
    
    func addTapGesture(){
        let t = UITapGestureRecognizer.init(target: self, action: #selector(handleGesture(tap:)))
        addGestureRecognizer(t)
        print(t)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("---------")
    }
    
    @objc func handleGesture(tap : UITapGestureRecognizer){
        print("------lzview的点击------")
        delegate?.lzViewClicked()
    }

}
