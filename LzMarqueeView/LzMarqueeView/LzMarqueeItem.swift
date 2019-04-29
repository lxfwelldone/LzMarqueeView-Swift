//
//  LzMarqueeItem.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/29.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit


protocol LzMarqueeItemProtocol : class {
    func lzMarqueeItemClicked(item : LzMarqueeItem, model : Person)
}

class LzMarqueeItem: UIView {
    
    weak var delegate : LzMarqueeItemProtocol? = nil
    
    var model : Person? = nil
    private lazy var lblName : UILabel = {
        let lblName = UILabel()
        lblName.text = "这是名字"
        lblName.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        lblName.textColor = UIColor.white
        return lblName
    }()
    
    private lazy var lblAge : UILabel = {
        let lblAge = UILabel()
        lblAge.text = "这是年龄"
        lblAge.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        lblAge.textColor = UIColor.white
        return lblAge
    }()
    
    private lazy var imgHeadView : UIImageView = {
       let imgHeadView = UIImageView()
        imgHeadView.image = UIImage(named: "p.jpg")
        imgHeadView.layer.cornerRadius = 5
        imgHeadView.layer.masksToBounds = true
        return imgHeadView
    }()

    
    private lazy var tapGesture : UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action:Selector.init(("clickOnItem")))
        return tapGesture
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LzMarqueeItem {
    
    func clickOnItem() {
        delegate?.lzMarqueeItemClicked(item: self, model: model!)
    }
    
    func setUI() {
        addSubview(imgHeadView)
        addSubview(lblName)
        addSubview(lblAge)
        
        lblAge.frame = CGRect.init(x: self.frame.size.width-50, y: 0, width: 40, height: self.frame.size.height)
        lblName.frame = CGRect.init(x: 60, y: 0, width: self.frame.size.width-100, height: self.frame.size.height)
        imgHeadView.frame = CGRect.init(x: 10, y: (self.frame.size.height-40)/2, width: 40, height: 40)
        addGestureRecognizer(tapGesture)
    }
    
    public func displayModel(model : Person){
        if !model.name.isEmpty {
            self.model = model
            lblName.text = self.model!.name
            lblAge.text = String(self.model!.age)
        }
    }

}
