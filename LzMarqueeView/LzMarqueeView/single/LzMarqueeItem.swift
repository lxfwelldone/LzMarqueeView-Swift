//
//  LzMarqueeItem.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/29.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit


protocol LzMarqueeItemDelegate : class {
    func clickOnMarqueeItem(itemView : LzMarqueeItem, model : Person)
}

class LzMarqueeItem : UIView{
    
    var model : Person?
    weak var delegate : LzMarqueeItemDelegate?

    private lazy var lblName : UILabel = {
        let name = UILabel()
        name.text = "这是名字"
        name.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        name.textColor = UIColor.white
        return name
    }()
    
    private lazy var lblAge : UILabel = {
        let age = UILabel()
        age.text = "这是年龄"
        age.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        age.textColor = UIColor.white
        return age
    }()
    
    private lazy var imgHeadView : UIImageView = {
        let headImage = UIImageView()
        headImage.image = UIImage(named: "p.jpg")
        headImage.layer.cornerRadius = 5
        headImage.layer.masksToBounds = true
        return headImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addTapGes()
        isHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LzMarqueeItem {

    func setUI() {
        addSubview(imgHeadView)
        addSubview(lblName)
        addSubview(lblAge)
        lblAge.frame = CGRect.init(x: self.frame.size.width-50, y: 0, width: 40, height: self.frame.size.height)
        lblName.frame = CGRect.init(x: 60, y: 0, width: self.frame.size.width-100, height: self.frame.size.height)
        imgHeadView.frame = CGRect.init(x: 10, y: (self.frame.size.height-40)/2, width: 40, height: 40)

    }
    
    /*
    * 为什么使用可选类型？ 因为如果是两个一起的话，数据源为单数的情况下，将会崩溃，因此使用可选类型进行处理
    */
    func displayModel(_ model : Person?){
        if  model != nil {
            self.model = model
            lblName.text = self.model!.name
            lblAge.text = String(self.model!.age)
            isHidden = false
        } else {
            isHidden = true
        }
    }
    
    
    /**
    * 添加点击手势
    */
    func addTapGes() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(tapOnItem(gesture:)))
        addGestureRecognizer(tapGesture)
    }
    /**
     * 点击手势的事件
     */
    @objc func tapOnItem(gesture : UITapGestureRecognizer) {
        print("点击方法：tapOnItem")
        if model != nil {
            delegate?.clickOnMarqueeItem(itemView: self, model: model!)
        }
    }
}
