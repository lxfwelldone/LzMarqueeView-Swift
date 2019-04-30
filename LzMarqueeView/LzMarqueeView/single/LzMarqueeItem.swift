//
//  LzMarqueeItem.swift
//  LzMarqueeView
//
//  Created by mc on 2019/4/29.
//  Copyright © 2019年 lxf. All rights reserved.
//

import UIKit


protocol LzMarqueeItemProtocol : class {
    func lzMarqueeItemClicked(model : Person)
}

class LzMarqueeItem : UIView{
    
    var model : Person = Person()
    weak var delegate : LzMarqueeItemProtocol?

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

    
//    private lazy var tapGesture : UITapGestureRecognizer = { [weak self] in
//        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(LzMarqueeItem.tapOnItem))
//        return tapGesture
//    }()

    var tapGesture : UITapGestureRecognizer? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapOnItem() {
        if !model.name.isEmpty {
            self.delegate?.lzMarqueeItemClicked(model: model)
        }
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
        self.tapGesture = UITapGestureRecognizer()
        self.tapGesture?.addTarget(self, action: #selector(tapOnItem))
        self.addGestureRecognizer(self.tapGesture!)
    }
    
    /*
    * 为什么使用可选类型？ 因为如果是两个一起的话，数据源为单数的情况下，将会崩溃，因此使用可选类型进行处理
    */
    func displayModel(model : Person){
        if  !model.name.isEmpty {
            self.model = model
            lblName.text = self.model.name
            lblAge.text = String(self.model.age)
            isHidden = false
        } else {
            isHidden = true
        }
    }

}
